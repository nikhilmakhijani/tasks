include {
  path = find_in_parent_folders()
}

dependency "backend_service" {
  config_path = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/web-app/backend_service/terragrunt.hcl"
}
terraform {
  source = "/Users/nikhilmakhijani/terraformwork/kpmg/task_1/modules/glb"
}

inputs = {
  # ---------------------------------------------------------------
  #    Common Inputs
  # ---------------------------------------------------------------

  create_http_proxy  = false
  create_https_proxy = true
  region             = "us-central1"
  project_id         = "hazel-torus-350916"
  ip_protocol        = "TCP"
  ip_address         = "34.67.213.86"
  network            = "default"
  subnetwork         = "default"
  url_map_name       = "lb-test"
  default_service    = dependency.backend_service.outputs.backend_service

  # ---------------------------------------------------------------
  #    Https Inputs
  # ---------------------------------------------------------------


  https_fowarding_rule_name = "fe-https-lb"
  https_proxy_name          = "l7-lb-target-https-proxy"
  ssl_certificates          = ["projects/hazel-torus-350916/regions/us-central1/sslCertificates/my-certificate-20220608061022683000000001"]

  # ---------------------------------------------------------------
  #    Http Inputs
  # ---------------------------------------------------------------


  http_forwarding_rule_name = "fe-http-lb"
  http_port_range           = "80"
  http_proxy_name           = "l7-lb-target-http-proxy"
  host_rules = {
    "1" = {
      hosts        = ["mysite.com"]
      path_matcher = "mysite"
    }
    "2" = {
      hosts        = ["myothersite.com"]
      path_matcher = "otherpaths"
    }
  }
  path_matchers = {
    "mysite" = {
      default_service = dependency.backend_service.outputs.backend_service
      route_rules = {
        "1" = {
          priority        = 10
          prefix_match    = "/"
          full_path_match = null
          ignore_case     = false
          regex_match     = null
          service         = null
          weighted_backend_services = {
            "1" = {
              backend_service = dependency.backend_service.outputs.backend_service
              weight          = 100
            }
          }
        }
      }
      path_rule = {

      }

    }
    "otherpaths" = {
      default_service = dependency.backend_service.outputs.backend_service
      route_rules = {
      }
      path_rule = {
        "1" = {
          paths   = ["/"]
          service = null
          weighted_backend_services = {
            "1" = {
              backend_service = dependency.backend_service.outputs.backend_service
              weight          = 100
            }
          }
        }
      }

    }
  }
}