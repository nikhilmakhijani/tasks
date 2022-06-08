include {
  path = find_in_parent_folders()
}

dependency "instance_template" {
  config_path = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/web-app/instance_group/terragrunt.hcl"
}
terraform {
  source = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/modules/mig"
}

inputs = {
  network            = "default"
  subnetwork         = "default"
  subnetwork_project = "hazel-torus-350916"
  project_id         = "hazel-torus-350916"
  region             = "us-central1"
  hostname           = "example"
  instance_template  = dependency.instance_template.outputs.self_link
  update_policy      = []
  target_size        = 2
  named_ports = [{
    name = "http"
    port = 80
    },
  ]

  autoscaler_name     = "mig-autoscaler"
  max_replicas        = 3
  min_replicas        = 2
  cooldown_period     = 60
  autoscaling_mode    = "ON"
  autoscaling_enabled = true
  autoscaling_scale_in_control = {
    fixed_replicas   = 0
    percent_replicas = 30
    time_window_sec  = 600
  }
  autoscaling_lb = [{
    target = "0.8"
    }
  ]
  autoscaling_cpu = [
    {
      target = 0.5
    }
  ]
  autoscaling_metric = [
    {
      name   = "agent.googleapis.com/agent/memory_usage"
      target = 0.5
      type   = "GAUGE"
    }
  ]

}