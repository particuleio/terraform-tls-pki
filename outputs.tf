# The module's outputs

output "ca" {
  value = {
    private_key = tls_private_key.ca
    cert        = tls_self_signed_cert.ca
  }
  sensitive = true
}

output "certificates" {
  value = {
    for k, v in var.certificates : k => {
      private_key = tls_private_key.certificate[k]
      cert        = tls_locally_signed_cert.certificate[k]
    }
  }
  sensitive = true
}
