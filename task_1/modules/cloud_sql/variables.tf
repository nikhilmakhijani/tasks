variable "project_id" {
  type        = string
  description = "The Project ID."
}

variable "instance_name" {
  type        = string
  description = "Name of the resource."
}

variable "region" {
  type        = string
  description = "The region where the resource will be created."
}

variable "db_version" {
  type        = string
  description = "THe version for SQL"
}

variable "availability_type" {
  type        = string
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).'"
}

variable "tier" {
  type        = string
  description = "The machine type to use."
}