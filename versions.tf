# Specify required provider versions below

terraform {
  required_providers {
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "~> 0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3"
    }
  }
}
