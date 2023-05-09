# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  cidr = var.cidr # 10.0.0.0/16

  azs = var.azs # Availabily Zones

  public_subnets  = var.nat_subnets        # Nat Instance
  private_subnets = var.kubernetes_subnets # Controlplane & Workers
  #database_subnets = var.database_subnets # RDS Database

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_network_acl    = false
  manage_default_security_group = false

  tags = local.common_tags
}

# Attaching an EIP to an Instance with a pre-assigned private ip

resource "aws_eip" "eip-controlplane" {
  vpc = true

  instance                  = aws_instance.controlplane.id
  associate_with_private_ip = "10.0.1.10"
}

resource "aws_eip" "eip-node1" {
  vpc = true

  instance                  = aws_instance.node1.id
  associate_with_private_ip = "10.0.2.10"
}

resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.vpc_id
  }

  tags = {
    Name = "nat-route"
  }
}