module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VPC_CIDR

  azs             = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.PRIV_SUB1_CIDR, var.PRIV_SUB2_CIDR]
  public_subnets  = [var.PUB_SUB_CIDR]

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_network_acl    = false
  manage_default_security_group = false

  tags = {
    terraform  = true
    Enviroment = "prod"
  }
}

resource "aws_instance" "jdm-bastion-host" { // OS = Amazon OS
  ami                         = "ami-0bf97847fcd5c9f57"
  instance_type               = "t2.medium"
  key_name                    = "jr-dev-mm"
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.jdm-public-sg.id]
  user_data                   = file("web.sh")

  tags = {
    Name = "jdm-bastion-host"
  }
}