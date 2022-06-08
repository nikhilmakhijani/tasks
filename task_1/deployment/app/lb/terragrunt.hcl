include {
  path = find_in_parent_folders()
}

dependency "mig" {
  config_path = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/web-app/mig/terragrunt.hcl"
}
terraform {
  source = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/modules/lb"
}

inputs = {
  project_id            = "hazel-torus-350916"
  region                = "us-central1"
  backend_service_name  = "web-service"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  ig_group              = dependency.mig.outputs.instance_group
  forwarding_rule_name  = "fr-app"
    
}