/*output "vpc-id" {
  value = module.vpc.vpc_id
}

output "nat-subnets" {
  value = module.vpc.public_subnets[*]
}

output "kubernetes-subnets" {
  value = module.vpc.private_subnets[*]
}

output "nat-public" {
  value = aws_instance.nat.public_ip
}

output "nat-private" {
  value = aws_instance.nat.private_ip
}

output "controlplane" {
  value = aws_instance.controlplane.private_ip
}
*/