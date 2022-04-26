# Main module resources

resource "tls_private_key" "ca" {
  algorithm   = try(var.ca.algorithm, "ECDSA")
  ecdsa_curve = try(var.ca.algorithm, "ECDSA") == "ECDSA" ? try(var.ca.ecdsa_curve, "P384") : null
  rsa_bits    = try(var.ca.algorithm, "ECDSA") == "RSA" ? try(var.ca.rsa_bits, 4096) : null
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm     = tls_private_key.ca.algorithm
  private_key_pem   = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  subject {
    common_name         = try(var.ca.subject.common_name, "certificate-authority")
    organization        = try(var.ca.subject.organization, null)
    organizational_unit = try(var.ca.subject.organizational_unit, null)
    street_address      = try(var.ca.subject.street_address, null)
    locality            = try(var.ca.subject.locality, null)
    province            = try(var.ca.subject.province, null)
    country             = try(var.ca.subject.country, null)
    postal_code         = try(var.ca.subject.postal_code, null)
    serial_number       = try(var.ca.subject.serial_number, null)
  }

  validity_period_hours = try(var.ca.validity_period_hours, 87600)
  early_renewal_hours   = try(var.ca.early_renewal_hours, 2160)

  allowed_uses = try(var.ca.allowed_uses, [
    "cert_signing",
    "crl_signing",
    "code_signing",
    "server_auth",
    "client_auth",
    "digital_signature",
    "key_encipherment",
  ])
}

resource "tls_private_key" "certificate" {
  for_each    = var.certificates
  algorithm   = try(each.value.algorithm, "ECDSA")
  ecdsa_curve = try(each.value.algorithm, "ECDSA") == "ECDSA" ? try(each.value.ecdsa_curve, "P384") : null
  rsa_bits    = try(each.value.algorithm, "ECDSA") == "RSA" ? try(each.value.rsa_bits, 4096) : null
}

resource "tls_cert_request" "certificate" {
  for_each        = var.certificates
  key_algorithm   = tls_private_key.certificate[each.key].algorithm
  private_key_pem = tls_private_key.certificate[each.key].private_key_pem

  subject {
    common_name         = try(each.value.subject.common_name, null)
    organization        = try(each.value.subject.organization, null)
    organizational_unit = try(each.value.subject.organizational_unit, null)
    street_address      = try(each.value.subject.street_address, null)
    locality            = try(each.value.subject.locality, null)
    province            = try(each.value.subject.province, null)
    country             = try(each.value.subject.country, null)
    postal_code         = try(each.value.subject.postal_code, null)
    serial_number       = try(each.value.subject.serial_number, null)
  }

  dns_names    = try(each.value.dns_names, [])
  ip_addresses = try(each.value.ip_addresses, [])
  uris         = try(each.value.uris, [])
}

resource "tls_locally_signed_cert" "certificate" {
  for_each           = var.certificates
  cert_request_pem   = tls_cert_request.certificate[each.key].cert_request_pem
  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = try(each.value.validity_period_hours, 8740)
  early_renewal_hours   = try(each.value.early_renewal_hours, 720)

  allowed_uses = try(each.value.allowed_uses, [])
}

resource "pkcs12_from_pem" "certificate" {
  for_each        = var.certificates
  password        = random_password.certificate[each.key].result
  cert_pem        = tls_locally_signed_cert.certificate[each.key].cert_pem
  private_key_pem = tls_private_key.certificate[each.key].private_key_pem
  ca_pem          = tls_self_signed_cert.ca.cert_pem
}

resource "random_password" "certificate" {
  for_each = var.certificates
  length   = 32
}
