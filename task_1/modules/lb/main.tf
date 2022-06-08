resource "google_compute_region_backend_service" "this" {
  project                         = var.project_id
  name                            = var.backend_service_name
  region                          = var.region
  protocol                        = var.ip_protocol
  timeout_sec                     = var.timeout_sec
  load_balancing_scheme           = var.load_balancing_scheme
  session_affinity                = var.session_affinity
  health_checks                   = [google_compute_region_health_check.this.self_link]
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  depends_on = [
    google_compute_region_health_check.this
  ]
  backend {
    group = var.ig_group
  }
}

resource "google_compute_region_health_check" "this" {
  name               = "tcp-region-health-check"
  project            = var.project_id
  region             = var.region
  timeout_sec        = 1
  check_interval_sec = 1
  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_forwarding_rule" "this" {
  name                  = var.forwarding_rule_name
  project               = var.project_id
  region                = var.region
  backend_service       = google_compute_region_backend_service.this.id
  load_balancing_scheme = "INTERNAL"
  network               = "default"
  subnetwork            = "default"
  ports                 = ["8080"]
}
