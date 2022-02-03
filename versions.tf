# Specify required provider versions below

terraform {
  experiments = [module_variable_optional_attrs]

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3"
    }
  }
}
