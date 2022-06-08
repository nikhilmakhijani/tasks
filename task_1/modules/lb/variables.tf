variable "project_id" {
  description = "The project to deploy to."
}

variable "region" {
  description = "Name of the region."
  type        = string
}

variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

# variable "backends" {
#   description = "List of backends, should be a map of key-value pairs for each backend, must have the 'group' key. Refer https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service#backend for reference."
#   type        = list(any)
# }

variable "ig_group" {
  description = "ID of the instance group"
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
  type        = string
}

variable "session_affinity" {
  description = "The session affinity for the backends example: NONE, CLIENT_IP. Default is `NONE`. Possible values are NONE, CLIENT_IP, CLIENT_IP_PORT_PROTO, CLIENT_IP_PROTO, GENERATED_COOKIE, HEADER_FIELD, HTTP_COOKIE, and CLIENT_IP_NO_DESTINATION."
  type        = string
  default     = "NONE"
}

variable "timeout_sec" {
  description = "How many seconds to wait for the backend before considering it a failed request. Default is 30 seconds. Valid range is [1, 86400]."
  type        = string
  default     = "30"
}

variable "ip_protocol" {
  description = "The IP protocol for the backend and frontend forwarding rule."
  type        = string
}

variable "connection_draining_timeout_sec" {
  description = "Time for which instance will be drained (not accept new connections, but still work to finish started)."
  type        = number
  default     = null
}

variable "load_balancing_scheme" {
  description = "Indicates what kind of load balancing this regional backend service will be used for. Default value is \"INTERNAL\""
  type        = string
  validation {
    condition     = contains(["INTERNAL", "INTERNAL_MANAGED", "EXTERNAL", "EXTERNAL_MANAGED"], var.load_balancing_scheme)
    error_message = "Err: Please provide proper load balancing scheme: \"INTERNAL\" or \"INTERNAL_MANAGED\"or \"EXTERNAL_MANAGED\" or \"EXTERNAL\"."
  }
  default = "INTERNAL"
}