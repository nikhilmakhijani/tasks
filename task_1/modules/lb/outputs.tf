output "region_backend_service" {
  value       = google_compute_region_backend_service.this.self_link
  description = "The URI of the created backend service"
}

output "id" {
  value       = google_compute_region_backend_service.this.id
  description = "Identifier for regional backend service"
}