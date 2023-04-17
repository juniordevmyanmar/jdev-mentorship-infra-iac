output "vpc-id" {
  value = module.vpc.vpc_id
}

output "public-subnets-1" {
  value = module.vpc.public_subnets[0]
}

output "public-subnets-2" {
  value = module.vpc.public_subnets[1]
}

output "public-subnets-3" {
  value = module.vpc.public_subnets[2]
}

output "private-subnets-1" {
  value = module.vpc.private_subnets[0]
}

output "private-subnets-2" {
  value = module.vpc.private_subnets[1]
}

output "private-subnets-3" {
  value = module.vpc.private_subnets[2]
}

output "rds-private-subnets-1" {
  value = module.vpc.private_subnets[3]
}

output "rds-private-subnets-2" {
  value = module.vpc.private_subnets[4]
}


output "rds-private-subnets-3" {
  value = module.vpc.private_subnets[5]
}

output "jdm-bastion-host-public-ip" {
  value = aws_instance.jdm-bastion-host.public_ip
}


output "jdm-bastion-host-private-ip" {
  value = aws_instance.jdm-bastion-host.private_ip
}