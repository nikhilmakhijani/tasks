include {
  path = find_in_parent_folders()
}

dependency "mig" {
  config_path = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/deployment/app/app_mig/terragrunt.hcl"
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/modules/backend_service"
}

inputs = {
  create_regional = true
  project_id = "hazel-torus-350916"
  health_check = {
    check_interval_sec  = 5
    healthy_threshold   = 3
    name                = "backend-hc-http"
    port                = 8081
    request_path        = "/orders"
    timeout_sec         = 5
    unhealthy_threshold = 2
  }

 regional_backends = {
    "backend" = {
      affinity_cookie_ttl_sec         = 0
      connection_draining_timeout_sec = 0
      description                     = "be backend service"
      enable_cdn                      = false
      groups = [{
        balancing_mode               = "UTILIZATION"
        capacity_scaler              = 1
        group                        = dependency.mig.outputs.instance_group
         failover                    = false
        max_utilization              = 0
      }]
      port        = 8081
      port_name   = "backend"
      protocol    = "HTTP"
      timeout_sec = 1
    }
  }
  global_backends = {}
}