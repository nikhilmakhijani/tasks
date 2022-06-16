resource "google_compute_url_map" "this" {
  project         = var.project_id
  name            = var.url_map_name
  default_service = var.default_service

}

resource "google_compute_global_address" "this" {
  project = var.project_id
  name = "lb-ip"
}

resource "google_compute_target_http_proxy" "this" {
  name       = var.proxy_name
  project    = var.project_id
  proxy_bind = "false"
  url_map    = google_compute_url_map.this.self_link
}

resource "google_compute_global_forwarding_rule" "this" {
  ip_address            = google_compute_global_address.this.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = var.fr_name
  port_range            = "80-80"
  project               = var.project_id
  target                = google_compute_target_http_proxy.this.id
}
