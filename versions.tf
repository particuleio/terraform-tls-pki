terraform {
  required_version = "~> 1.0"
  required_providers {
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "~> 0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
