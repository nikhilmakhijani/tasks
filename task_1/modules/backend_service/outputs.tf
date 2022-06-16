output "backend_service_health_check_self_link" {
  value = var.create_regional ? google_compute_region_health_check.this[0].id : google_compute_http_health_check.this[0].id
  description = "Backend service health check self link."
}

output "fe_service_self_link" {
  value = { for k,v in var.global_backends : k => google_compute_backend_service.this["${k}"].id }
  description = "Backend service self link."
}

output "be_service_self_link" {
  value = { for k,v in var.regional_backends : k => google_compute_region_backend_service.this["${k}"].id }
  description = "Backend service self link."
}

