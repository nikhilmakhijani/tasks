include {
  path = find_in_parent_folders()
}

dependency "app_service" {
  config_path = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/deployment/app/app_backend_service/terragrunt.hcl"
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/modules/ilb"
}

inputs = {
project_id      = "hazel-torus-350916"
region          = "us-central1"
url_map_name    = "be-url-map"
network         = "default"
subnetwork      = "default"
default_service = "https://www.googleapis.com/compute/v1/${dependency.app_service.outputs.be_service_self_link["backend"]}"
proxy_name      = "be-proxy"
fr_name         = "be-fr"

}
