module "pki" {
  source = "../.."

  ca = {
    algorithm   = "ECDSA"
    ecdsa_curve = "P384"
    subject = {
      common_name         = "Certificate Authority"
      organization        = "Org"
      organizational_unit = "OU"
      street_address = [
        "Street"
      ]
      locality      = "Locality"
      province      = "Province"
      country       = "Country"
      postal_code   = "Postal Code"
      serial_number = "Serial Number"
    }
    validity_period_hours = 87600
    early_renewal_hours   = 78840
    allowed_uses = [
      "cert_signing",
      "crl_signing",
      "code_signing",
      "server_auth",
      "client_auth",
      "digital_signature",
      "key_encipherment",
    ]
  }

  certificates = {
    mycert = {
      algorithm   = "ECDSA"
      ecdsa_curve = "P384"
      subject = {
        common_name         = "Certificate Authority"
        organization        = "Org"
        organizational_unit = "OU"
        street_address = [
          "Street"
        ]
        locality      = "Locality"
        province      = "Province"
        country       = "Country"
        postal_code   = "Postal Code"
        serial_number = "Serial Number"
      }
      validity_period_hours = 8740
      early_renewal_hours   = 8040
      dns_names = [
        "mydomain.com"
      ]
      ip_addresses = [
        "10.0.0.1"
      ]
      uris = []
      allowed_uses = [
        "server_auth",
        "client_auth",
      ]
    }
  }
}

output "ca" {
  value     = module.pki.ca
  sensitive = true
}

output "certificates" {
  value     = module.pki.certificates
  sensitive = true
}
