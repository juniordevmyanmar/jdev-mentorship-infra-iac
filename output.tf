output "public_ip" {
  value = aws_instance.jdm-bastion-host.public_ip
}

output "public_dns" {
  value = aws_instance.jdm-bastion-host.public_dns
}