include {
  path = find_in_parent_folders()
}

dependency "mig" {
  config_path = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/deployment/frontend/frontend_mig/terragrunt.hcl"
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/modules/backend_service"
}

inputs = {
  create_regional = false
  project_id = "hazel-torus-350916"
  health_check = {
    check_interval_sec  = 5
    healthy_threshold   = 3
    name                = "frontend-hc-http"
    port                = 8080
    request_path        = "/"
    timeout_sec         = 5
    unhealthy_threshold = 2
  }

  global_backends = {
    "frontend" = {
      affinity_cookie_ttl_sec         = 0
      connection_draining_timeout_sec = 0
      custom_request_headers          = []
      custom_response_headers         = []
      description                     = "frontend backend service"
      enable_cdn                      = false
      groups = [{
        balancing_mode               = "UTILIZATION"
        capacity_scaler              = 1
        group                        = dependency.mig.outputs.instance_group
        max_connections              = 0
        max_connections_per_endpoint = 0
        max_connections_per_instance = 0
        max_rate                     = 0
        max_rate_per_endpoint        = 0
        max_rate_per_instance        = 0
        max_utilization              = 0
      }]
      port        = 8080
      port_name   = "frontend"
      protocol    = "HTTP"
      timeout_sec = 1
    }
  }
  regional_backends = {}
}