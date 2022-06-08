output "self_link" {
  value       = google_sql_database_instance.this.self_link
  description = "The URI of the created resource."
}