module "pki" {
  source = "../.."
}

output "ca" {
  value     = module.pki.ca
  sensitive = true
}

output "certificates" {
  value     = module.pki.certificates
  sensitive = true
}
