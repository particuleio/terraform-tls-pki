# terraform-module-template

Repository template for Particule's Terraform module.

## Usage


### Examples

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | ~> 0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pkcs12"></a> [pkcs12](#provider\_pkcs12) | ~> 0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pkcs12_from_pem.certificate](https://registry.terraform.io/providers/chilicat/pkcs12/latest/docs/resources/from_pem) | resource |
| [random_password.certificate](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_cert_request.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca"></a> [ca](#input\_ca) | n/a | `any` | <pre>{<br>  "algorithm": "ECDSA",<br>  "allowed_uses": [<br>    "cert_signing",<br>    "crl_signing",<br>    "code_signing",<br>    "server_auth",<br>    "client_auth",<br>    "digital_signature",<br>    "key_encipherment"<br>  ],<br>  "early_renewal_hours": 78840,<br>  "ecdsa_curve": "P384",<br>  "rsa_bits": 4096,<br>  "subject": {<br>    "common_name": "certificate-authority"<br>  },<br>  "validity_period_hours": 87600<br>}</pre> | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | n/a | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca"></a> [ca](#output\_ca) | n/a |
| <a name="output_certificates"></a> [certificates](#output\_certificates) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
