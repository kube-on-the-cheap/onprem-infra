# dns

<!-- BEGIN_TF_DOCS -->
# DNS Management

This module takes care of creating a zone in DigitalOcean, provide info on how to implement delegation from its parent, and adds the token to be used with ExternalDNS in an OCI Vault Secret for later use.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~>5 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~>2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.15.0 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.72.0 |

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.onprem_delegation](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [digitalocean_domain.onprem](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain) | resource |
| [digitalocean_project_resources.kotc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [cloudflare_zone.parent_domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |
| [digitalocean_project.kotc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [digitalocean_records.onprem_ns](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/records) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The parent OCI domain name | `any` | n/a | yes |
| <a name="input_onprem_domain_name"></a> [onprem\_domain\_name](#input\_onprem\_domain\_name) | The domain used to host onprem resources | `any` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The DigitalOcean project name to create the domain in | `string` | n/a | yes |
<!-- END_TF_DOCS -->
