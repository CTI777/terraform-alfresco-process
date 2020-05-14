# aws_efs module

This module creates an EFS NFS server for ACS to use.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | name for your cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_efs\_dns\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
