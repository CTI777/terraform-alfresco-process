# docker_registry_aws module

Module that sets up a Docker registry on AWS backed by S3.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| helm | ~> 0.10 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | ~> 0.10 |
| local | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_access\_key\_id | AWS access key | `any` | n/a | yes |
| aws\_region | AWS region | `any` | n/a | yes |
| aws\_secret\_access\_key | AWS secret key | `any` | n/a | yes |
| cluster\_name | name for your cluster, if not set it will be a concatenation of project\_name and project\_environment | `any` | n/a | yes |
| helm\_service\_account | service account used by helm | `string` | `"tiller"` | no |
| registry\_host | registry host | `any` | n/a | yes |
| registry\_password | password for the deployment docker registry | `any` | n/a | yes |
| registry\_user | username for the deployment docker registry | `any` | n/a | yes |
| zone\_domain | Zone domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| registry\_host | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
