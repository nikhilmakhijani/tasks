remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "my-terraform-state-test"
    prefix = "states/${path_relative_to_include()}/terraform.tfstate"
    project = "hazel-torus-350916"
    location = "us"
  }
}

generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"
    contents = <<EOF
provider "google" {

  impersonate_service_account  = "sa-terraform@hazel-torus-350916.iam.gserviceaccount.com"
}
EOF
}