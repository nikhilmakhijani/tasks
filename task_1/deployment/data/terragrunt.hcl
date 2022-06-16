include {
  path = find_in_parent_folders()
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/tasks/task_1/modules/cloud_sql"
}

inputs = {
  project_id        = "hazel-torus-350916"
  region            = "us-central1"
  instance_name     = "test-ha"
  db_version        = "POSTGRES_14"
  tier              = "db-f1-micro"
  availability_type = "REGIONAL"
}