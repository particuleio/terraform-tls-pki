# Main module resources

resource "tls_private_key" "ca" {
  algorithm   = lookup(var.ca, "algorithm", "ECDSA")
  ecdsa_curve = lookup(var.ca, "algorithm", "ECDSA") == "ECDSA" ? var.ca.ecdsa_curve : null
  rsa_bits    = lookup(var.ca, "algorithm", "ECDSA") == "RSA" ? var.ca.rsa_bits : null
}


resource "tls_self_signed_cert" "ca" {
  key_algorithm     = tls_private_key.ca.algorithm
  private_key_pem   = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  subject {
    common_name         = lookup(var.ca.subject, "common_name", null)
    organization        = lookup(var.ca.subject, "organization", null)
    organizational_unit = lookup(var.ca.subject, "organizational_unit", null)
    street_address      = lookup(var.ca.subject, "street_address", null)
    locality            = lookup(var.ca.subject, "locality", null)
    province            = lookup(var.ca.subject, "province", null)
    country             = lookup(var.ca.subject, "country", null)
    postal_code         = lookup(var.ca.subject, "postal_code", null)
    serial_number       = lookup(var.ca.subject, "serial_number", null)
  }

  validity_period_hours = lookup(var.ca, "validity_period_hours", 87600)
  early_renewal_hours   = lookup(var.ca, "early_renewal_hours", 78840)

  allowed_uses = var.ca.allowed_uses
}

resource "tls_private_key" "certificate" {
  for_each    = var.certificates
  algorithm   = lookup(each.value, "algorithm", "ECDSA")
  ecdsa_curve = lookup(each.value, "algorithm", "ECDSA") == "ECDSA" ? lookup(each.value, "ecdsa_curve", "P384") : null
  rsa_bits    = lookup(each.value, "algorithm", "ECDSA") == "RSA" ? lookup(each.value, "rsa_bits", 4096) : null
}

resource "tls_cert_request" "certificate" {
  for_each        = var.certificates
  key_algorithm   = tls_private_key.certificate[each.key].algorithm
  private_key_pem = tls_private_key.certificate[each.key].private_key_pem

  subject {
    common_name         = lookup(each.value.subject, "common_name", null)
    organization        = lookup(each.value.subject, "organization", null)
    organizational_unit = lookup(each.value.subject, "organizational_unit", null)
    street_address      = lookup(each.value.subject, "street_address", null)
    locality            = lookup(each.value.subject, "locality", null)
    province            = lookup(each.value.subject, "province", null)
    country             = lookup(each.value.subject, "country", null)
    postal_code         = lookup(each.value.subject, "postal_code", null)
    serial_number       = lookup(each.value.subject, "serial_number", null)
  }

  dns_names    = lookup(each.value, "dns_names", [])
  ip_addresses = lookup(each.value, "ip_addresses", [])
  uris         = lookup(each.value, "uris", [])
}

resource "tls_locally_signed_cert" "certificate" {
  for_each           = var.certificates
  cert_request_pem   = tls_cert_request.certificate[each.key].cert_request_pem
  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = lookup(each.value, "validity_period_hours", 8740)
  early_renewal_hours   = lookup(each.value, "early_renewal_hours", 8040)

  allowed_uses = lookup(each.value, "allowed_uses", [])
}
