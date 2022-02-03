# Define the module's input below

variable "ca" {
  default = {
    algorithm             = "ECDSA"
    ecdsa_curve           = "P384"
    rsa_bits              = 4096
    validity_period_hours = 87600
    early_renewal_hours   = 78840
    subject               = {}
    allowed_uses = [
      "cert_signing",
      "crl_signing"
    ]
  }
  type = object({
    algorithm             = optional(string)
    ecdsa_curve           = optional(string)
    rsa_bits              = optional(number)
    validity_period_hours = optional(number)
    early_renewal_hours   = optional(number)
    subject               = optional(map(any))
    allowed_uses          = optional(list(any))
  })
}

variable "certificates" {
  default = {}
  type = map(object({
    algorithm             = optional(string)
    ecdsa_curve           = optional(string)
    rsa_bits              = optional(number)
    validity_period_hours = optional(number)
    early_renewal_hours   = optional(number)
    subject               = optional(map(any))
    allowed_uses          = optional(list(any))
    dns_names             = optional(list(any))
    ip_addresses          = optional(list(any))
  }))
}
