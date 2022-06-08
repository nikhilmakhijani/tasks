include {
  path = find_in_parent_folders()
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/modules/glb"
}

dependency "mig" {
  config_path = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/deployment/web/mig/terragrunt.hcl"
}

inputs = {
  project_id        = "hazel-torus-350916"
  instance_group_id = dependency.mig.outputs.instance_group
}