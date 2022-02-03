# Define the module's input below

variable "ca" {
  type = any
  default = {
    algorithm             = "ECDSA"
    ecdsa_curve           = "P384"
    rsa_bits              = 4096
    validity_period_hours = 87600
    early_renewal_hours   = 78840
    subject = {
      common_name = "certificate-authority"
    }
    allowed_uses = [
      "cert_signing",
      "crl_signing"
    ]
  }
}

variable "certificates" {
  type    = any
  default = {}
}
