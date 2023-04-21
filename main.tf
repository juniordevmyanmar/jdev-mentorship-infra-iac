module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = var.vpc-name
  cidr = var.vpc-cidr

  azs = [var.zone-a, var.zone-b, var.zone-c]

  public_subnets = [var.public-subnet-1, var.public-subnet-2, var.public-subnet-3]

  private_subnets = [
    var.private-subnet-1, var.private-subnet-2, var.private-subnet-3,
    var.rds-private-subnet-1, var.rds-private-subnet-2, var.rds-private-subnet-3
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_network_acl    = false
  manage_default_security_group = false

  tags = {
    terraform  = true
    Enviroment = "prod"
  }
}

resource "aws_instance" "jdm-bastion-host" { // OS = Ubuntu
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.micro"
  key_name                    = var.env
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.jdm-public-sg.id]

  tags = {
    Name = "${var.project}-jdmm-bastion-host"
  }
}

resource "aws_instance" "Kube-control" { // OS = Amazon OS
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.medium"
  key_name                    = var.env
  associate_public_ip_address = true
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [aws_security_group.jdm-private-sg.id]

  tags = {
    Name = "${var.project}-Kube-control"
  }
}

resource "aws_instance" "Kube-worker" { // OS = Amazon OS
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.medium"
  key_name                    = var.env
  associate_public_ip_address = true
  subnet_id                   = module.vpc.private_subnets[1]
  vpc_security_group_ids      = [aws_security_group.jdm-private-sg.id]

  tags = {
    Name = "${var.project}-Kube-Worker"
  }
}