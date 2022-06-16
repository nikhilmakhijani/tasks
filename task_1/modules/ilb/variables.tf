variable "project_id" {
  description = "The project ID in which the resource belongs."
  type        = string
}

variable "region" {
  description = "Name of the region."
  type        = string
}

variable "network" {
  description = "The network that the load balanced IP should belong to."
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork that the load balanced IP should belong to."
  type        = string
}


variable "ip_protocol" {
  description = "The IP protocol for the backend and frontend forwarding rule: TCP or UDP."
  type        = string
  default     = "TCP"
}

variable "address" {
  description = "The IP address for the internal load balancer. If it is not specified an IP will be automatically allocated from the subnetwork range."
  type        = string
  default     = ""
}

variable "url_map_name" {
  type        = string
  description = "Name of the URL Map."
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
