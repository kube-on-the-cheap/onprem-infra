# tailscale

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |
| <a name="requirement_tailscale"></a> [tailscale](#requirement\_tailscale) | ~> 0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |
| <a name="provider_tailscale"></a> [tailscale](#provider\_tailscale) | 0.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.tailscale](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.tailscale_oauth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [tailscale_oauth_client.this](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/oauth_client) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace to create the secret in | `string` | `"tailscale"` | no |
| <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name) | Description for the Tailscale OAuth client | `string` | n/a | yes |
| <a name="input_oauth_client_tags"></a> [oauth\_client\_tags](#input\_oauth\_client\_tags) | Tags that the OAuth client can assign to devices | `list(string)` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | The name of the Kubernetes secret to create | `string` | `"tailscale-oauth"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
