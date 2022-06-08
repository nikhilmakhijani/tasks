resource "google_sql_database_instance" "this" {
  name             = var.instance_name
  project          = var.project_id
  region           = var.region
  database_version = var.db_version
  settings {
    tier              = var.tier
    availability_type = var.availability_type
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
      start_time         = "20:55"
    }
  }
  deletion_protection = "true"
}