include {
  path = find_in_parent_folders()
}

terraform {
  source = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/modules/instance_template"
}

inputs = {
  project_id = "hazel-torus-350916"
  region     = "us-central1"
  service_account = {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "sa-terraform@hazel-torus-350916.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  name_prefix  = "backend"
  machine_type = "e2-medium"
  disk_type    = "pd-standard"
  metadata = {
    enable-osconfig = "true"
  }
  enable_shielded_vm   = true
  source_image         = "debian-10"
  source_image_family  = "debian-10"
  source_image_project = "debian-cloud"
  disk_size_gb         = "20"
  network              = "default"
  subnetwork           = "default"
  subnetwork_project   = "hazel-torus-350916"
  tags                 = ["http-server", "https-server"]
  access_config        = []
  labels = {

  }
}