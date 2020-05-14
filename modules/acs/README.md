# acs module

This module installs Alfresco Content Services.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| helm | ~> 0.10 |
| kubernetes | ~> 1.7 |

## Providers

| Name | Version |
|------|---------|
| helm | ~> 0.10 |
| kubernetes | ~> 1.7 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acs\_enabled | install Alfresco Content Services | `bool` | `true` | no |
| cluster\_host | cluster host | `any` | n/a | yes |
| helm\_service\_account | service account used by helm | `string` | `"tiller"` | no |
| identity\_host | identity host | `any` | n/a | yes |
| namespace | kubernetes namespace to install to | `string` | `"acs"` | no |
| quay\_password | quay user password | `any` | n/a | yes |
| quay\_url | quay url in docker registry format, defaults to "quay.io" | `string` | `"quay.io"` | no |
| quay\_user | quay user name | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
