# terraform-module-template

Repository template for Particule's Terraform module.

## Usage


### Examples

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tls_cert_request.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.certificates](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca"></a> [ca](#input\_ca) | n/a | <pre>object({<br>    algorithm             = optional(string)<br>    ecdsa_curve           = optional(string)<br>    rsa_bits              = optional(number)<br>    validity_period_hours = optional(number)<br>    early_renewal_hours   = optional(number)<br>    subject               = optional(map(any))<br>    allowed_uses          = optional(list(any))<br>  })</pre> | <pre>{<br>  "algorithm": "ECDSA",<br>  "allowed_uses": [<br>    "cert_signing",<br>    "crl_signing"<br>  ],<br>  "early_renewal_hours": 78840,<br>  "ecdsa_curve": "P384",<br>  "rsa_bits": 4096,<br>  "subject": {},<br>  "validity_period_hours": 87600<br>}</pre> | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | n/a | <pre>map(object({<br>    algorithm             = optional(string)<br>    ecdsa_curve           = optional(string)<br>    rsa_bits              = optional(number)<br>    validity_period_hours = optional(number)<br>    early_renewal_hours   = optional(number)<br>    subject               = optional(map(any))<br>    allowed_uses          = optional(list(any))<br>    dns_names             = optional(list(any))<br>    ip_addresses          = optional(list(any))<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
