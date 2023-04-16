## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.jdm-bastion-host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.jr-dev-mm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.jdm-private-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.jdm-public-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AMIS"></a> [AMIS](#input\_AMIS) | n/a | `map(any)` | <pre>{<br>  "ap-southeast-1": "ami-0bf97847fcd5c9f57"<br>}</pre> | no |
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | n/a | `string` | `"ap-southeast-1"` | no |
| <a name="input_NAME"></a> [NAME](#input\_NAME) | n/a | `string` | `"jr-dev-mm"` | no |
| <a name="input_PRIV_KEY_PATH"></a> [PRIV\_KEY\_PATH](#input\_PRIV\_KEY\_PATH) | n/a | `string` | `"jr-dev-mm"` | no |
| <a name="input_PRIV_SUB1_CIDR"></a> [PRIV\_SUB1\_CIDR](#input\_PRIV\_SUB1\_CIDR) | n/a | `string` | `"192.168.2.0/24"` | no |
| <a name="input_PRIV_SUB2_CIDR"></a> [PRIV\_SUB2\_CIDR](#input\_PRIV\_SUB2\_CIDR) | n/a | `string` | `"192.168.3.0/24"` | no |
| <a name="input_PROJECT"></a> [PROJECT](#input\_PROJECT) | n/a | `string` | `"JuniorDev Myanmar"` | no |
| <a name="input_PUB_KEY_PATH"></a> [PUB\_KEY\_PATH](#input\_PUB\_KEY\_PATH) | n/a | `string` | `"jr-dev-mm.pub"` | no |
| <a name="input_PUB_SUB_CIDR"></a> [PUB\_SUB\_CIDR](#input\_PUB\_SUB\_CIDR) | n/a | `string` | `"192.168.1.0/24"` | no |
| <a name="input_USERNAME"></a> [USERNAME](#input\_USERNAME) | n/a | `string` | `"ec2-user"` | no |
| <a name="input_VPC_CIDR"></a> [VPC\_CIDR](#input\_VPC\_CIDR) | n/a | `string` | `"192.168.0.0/16"` | no |
| <a name="input_VPC_NAME"></a> [VPC\_NAME](#input\_VPC\_NAME) | n/a | `string` | `"JrDevMM"` | no |
| <a name="input_ZONE1"></a> [ZONE1](#input\_ZONE1) | n/a | `string` | `"ap-southeast-1a"` | no |
| <a name="input_ZONE2"></a> [ZONE2](#input\_ZONE2) | n/a | `string` | `"ap-southeast-1b"` | no |
| <a name="input_ZONE3"></a> [ZONE3](#input\_ZONE3) | n/a | `string` | `"ap-southeast-1c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
