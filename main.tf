##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# SSH Key & Secret Manager RESOURCES
##################################################################################

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "aws_key_pair" "instance" {
  key_name   = "var.company-${random_integer.rand.result}"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Create and stores ssh key used creating an EC2 instance
resource "aws_secretsmanager_secret" "secrets_manager" {
  name = "var.company-${random_integer.rand.result}"
}

resource "aws_secretsmanager_secret_version" "ssh_key" {
  secret_id     = aws_secretsmanager_secret.secrets_manager.id
  secret_string = tls_private_key.ssh.private_key_pem
}

##################################################################################
# VPC Modules
##################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = var.name
  cidr = var.cidr # 10.0.0.0/16

  azs = slice(data.aws_availability_zones.available.names, 0, (var.no_count)) # Availabily Zones

  public_subnets = [for subnet in range(1) : cidrsubnet(var.cidr, 8, subnet)]

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_network_acl    = false
  manage_default_security_group = false
}

##################################################################################
# NAT Subnet RESOURCES
##################################################################################

resource "aws_subnet" "private" {
  cidr_block        = var.private_subnets[0]
  vpc_id            = module.vpc.vpc_id
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = local.common_tags
}

# NAT Subnet with routing #
resource "aws_route_table" "rtb" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat_bastion_host.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.rtb.id
}

##################################################################################
# Security Group RESOURCES
##################################################################################

# NAT instance Security Group
resource "aws_security_group" "nat" {
  name        = "NAT-security-group"
  description = "NAT Instance Security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

# Kubernetes Instance Security Group
resource "aws_security_group" "kubernetes" {
  name        = "Kubernetes-security-group"
  description = "Kubernetes Instance Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow All Traffic only from nat security group
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.nat.id]
  }

  tags = local.common_tags
}

##################################################################################
# Instances RESOURCES
##################################################################################

# Nat Bastion Host #
resource "aws_instance" "nat_bastion_host" { # Nat Instance
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.instance.id
  source_dest_check           = false
  associate_public_ip_address = true

  availability_zone      = data.aws_availability_zones.available.names[0]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.nat.id]
  user_data              = file("scripts/nat_bastion_host-startup_script.sh")

  tags = merge(local.common_tags, {
    Name = "nat-bastion-jumphost"
  })
}

resource "aws_instance" "controlplane" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.instance.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.kubernetes.id]

  tags = merge(local.common_tags, {
    Name = "controlplane"
  })
}

resource "aws_instance" "worker" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.instance.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.kubernetes.id]

  tags = merge(local.common_tags, {
    Name = "worker"
  })
}