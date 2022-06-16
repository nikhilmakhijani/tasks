resource "google_compute_forwarding_rule" "this" {
  name                  = var.fr_name
  region                = var.region
  project               = var.project_id
  ip_protocol           = var.ip_protocol
  ip_address            = google_compute_address.this.id
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.this.id
  network               = var.network
  subnetwork            = var.subnetwork
  network_tier          = "PREMIUM"
}

resource "google_compute_region_target_http_proxy" "this" {
  name        = var.proxy_name
  region      = var.region
  project     = var.project_id
  url_map     = google_compute_region_url_map.this.id
}

resource "google_compute_address" "this" {
  name         = "ilb-ip"
  project      = var.project_id
  region       = var.region
  subnetwork   = var.subnetwork
  purpose      = "GCE_ENDPOINT"
  address_type = "INTERNAL"
  address      = var.address
}


resource "google_compute_region_url_map" "this" {
  name            = var.url_map_name
  region          = var.region
  project         = var.project_id
  default_service = var.default_service
host_rule {
    hosts        = ["mysite.com"]
    path_matcher = "orders"
  }

  path_matcher {
    name            = "orders"
    default_service = var.default_service

    path_rule {
      paths   = ["/orders"]
      service = var.default_service
    }
}
}