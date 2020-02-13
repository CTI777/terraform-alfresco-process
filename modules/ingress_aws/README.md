# ingress_aws module

This module creates an ingress on AWS with ELB, DNS rules on Route53 and HTTPS certificate on Certificate Manager.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | 0.10.0 |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_domain | cluster domain | `any` | n/a | yes |
| cluster\_name | name for your cluster, if not set it will be a concatenation of project\_name and project\_environment | `any` | n/a | yes |
| gateway\_host | gateway host | `any` | n/a | yes |
| helm\_service\_account | service account used by helm | `string` | `"tiller"` | no |
| identity\_host | identity host | `any` | n/a | yes |
| registry\_host | registry host | `any` | n/a | yes |
| zone\_domain | Zone domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| gateway\_host | n/a |
| registry\_host | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
