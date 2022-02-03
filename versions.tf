# Specify required provider versions below

terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3"
    }
  }
}
