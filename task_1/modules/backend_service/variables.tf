variable "project_id" {
  type        = string
  description = "The project to deploy to."
}

variable "region" {
  type  = string
  description = "Region to deploy resources in."
  default = "us-central1"
}

variable "create_regional" {
  type = bool
  default = false
  description = "Whether you want to create regional backend service."
}

variable "health_check" {
  type = object({
    name                = string
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    request_path        = string
    port                = number
  })
}

variable "global_backends" {
  description = "Map backend indices to list of backend maps."
  type = map(object({
    protocol                        = string
    port                            = number
    port_name                       = string
    description                     = string
    enable_cdn                      = bool
    custom_request_headers          = list(string)
    custom_response_headers         = list(string)
    timeout_sec                     = number
    connection_draining_timeout_sec = number
    affinity_cookie_ttl_sec         = number
    groups = list(object({
      group                        = string
      balancing_mode               = string
      capacity_scaler              = number
      max_connections              = number
      max_connections_per_instance = number
      max_connections_per_endpoint = number
      max_rate                     = number
      max_rate_per_instance        = number
      max_rate_per_endpoint        = number
      max_utilization              = number
    }))
  }))
}

variable "regional_backends" {
  description = "Map backend indices to list of backend maps."
  type = map(object({
    protocol                        = string
    port                            = number
    port_name                       = string
    description                     = string
    enable_cdn                      = bool
    timeout_sec                     = number
    connection_draining_timeout_sec = number
    affinity_cookie_ttl_sec         = number
    groups = list(object({
      group                        = string
      balancing_mode               = string
      failover                     = bool
      capacity_scaler              = number
      max_utilization              = number
    }))
  }))
}