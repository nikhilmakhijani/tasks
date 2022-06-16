include {
  path = find_in_parent_folders()
}

dependency "backend_service" {
  config_path = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/deployment/frontend/frontend_backend_service/terragrunt.hcl"
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/modules/lb"
}

inputs = {
project_id      = "hazel-torus-350916"
url_map_name    = "fe-url-map"
default_service = "https://www.googleapis.com/compute/v1/${dependency.backend_service.outputs.backend_service_self_link["frontend"]}"
proxy_name      = "fe-proxy"
fr_name         = "fe-fr"
}
