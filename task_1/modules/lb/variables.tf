variable "url_map_name" {
  type        = string
  description = "Name of the URL Map."
}

variable "project_id" {
  type        = string
  description = "The project ID in which the resource belongs."
}

variable "default_service" {
  type        = string
  description = "The full or partial URL of the defaultService resource."
}

variable "proxy_name" {
  type        = string
  description = "Name of the proxy."
}

variable "fr_name" {
  type        = string
  description = "Name of the forwarding rule."
}
