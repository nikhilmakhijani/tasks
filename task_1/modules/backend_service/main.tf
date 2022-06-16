resource "google_compute_http_health_check" "this" {
  count  = var.create_regional ? 0 : 1
  project             = var.project_id
  check_interval_sec  = var.health_check.check_interval_sec
  healthy_threshold   = var.health_check.healthy_threshold
  name                = var.health_check.name
  port                = var.health_check.port
  request_path        = var.health_check.request_path
  timeout_sec         = var.health_check.timeout_sec
  unhealthy_threshold = var.health_check.unhealthy_threshold
}

resource "google_compute_backend_service" "this" {
  for_each                        = length(var.global_backends) > 0 ? var.global_backends : {}
  project                         = var.project_id
  name                            = "${each.key}-gbackend"
  port_name                       = each.value.port_name
  protocol                        = each.value.protocol
  timeout_sec                     = lookup(each.value, "timeout_sec", null)
  description                     = lookup(each.value, "description", null)
  connection_draining_timeout_sec = lookup(each.value, "connection_draining_timeout_sec", null)
  enable_cdn                      = lookup(each.value, "enable_cdn", false)
  custom_request_headers          = lookup(each.value, "custom_request_headers", [])
  custom_response_headers         = lookup(each.value, "custom_response_headers", [])
  load_balancing_scheme           = "EXTERNAL"
  health_checks                   = [google_compute_http_health_check.this[0].id]
  affinity_cookie_ttl_sec         = lookup(each.value, "affinity_cookie_ttl_sec", null)
  dynamic "backend" {
    for_each = toset(each.value["groups"])
    content {
      balancing_mode               = lookup(backend.value, "balancing_mode")
      group                        = lookup(backend.value, "group")
      capacity_scaler              = lookup(backend.value, "capacity_scaler")
      max_connections              = lookup(backend.value, "max_connections")
      max_connections_per_instance = lookup(backend.value, "max_connections_per_instance")
      max_connections_per_endpoint = lookup(backend.value, "max_connections_per_endpoint")
      max_rate                     = lookup(backend.value, "max_rate")
      max_rate_per_instance        = lookup(backend.value, "max_rate_per_instance")
      max_rate_per_endpoint        = lookup(backend.value, "max_rate_per_endpoint")
      max_utilization              = lookup(backend.value, "max_utilization")
    }
  }
}

resource "google_compute_region_health_check" "this" {
  count  = var.create_regional ? 1 : 0
  name        = var.health_check.name
  project =  var.project_id
  region = var.region
  timeout_sec         = var.health_check.timeout_sec
  check_interval_sec  = var.health_check.check_interval_sec
  healthy_threshold   = var.health_check.healthy_threshold
  unhealthy_threshold = var.health_check.unhealthy_threshold

  http_health_check {
    port         = var.health_check.port
    port_specification = "USE_FIXED_PORT"
    host               = ""
    request_path       = var.health_check.request_path
    proxy_header       = "NONE"
  }
}

resource "google_compute_region_backend_service" "this" {
  for_each                        = length(var.regional_backends) > 0 ? var.regional_backends : {}
  project                         = var.project_id
  region                          = var.region
  name                            = "${each.key}-rbackend"
  port_name                       = each.value.port_name
  protocol                        = each.value.protocol
  timeout_sec                     = lookup(each.value, "timeout_sec", null)
  description                     = lookup(each.value, "description", null)
  connection_draining_timeout_sec = lookup(each.value, "connection_draining_timeout_sec", null)
  enable_cdn                      = lookup(each.value, "enable_cdn", false)
  load_balancing_scheme           = "INTERNAL_MANAGED"
  health_checks                   = [google_compute_region_health_check.this[0].id]
  affinity_cookie_ttl_sec         = lookup(each.value, "affinity_cookie_ttl_sec", null)
  dynamic "backend" {
    for_each = toset(each.value["groups"])
    content {
      balancing_mode               = lookup(backend.value, "balancing_mode")
      group                        = lookup(backend.value, "group")
      failover                     = lookup(backend.value, "failover", null)
      capacity_scaler              = lookup(backend.value, "capacity_scaler")
      max_utilization              = lookup(backend.value, "max_utilization")
    }
  }
}
