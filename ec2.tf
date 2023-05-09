
# NAT #

resource "aws_instance" "bastion_nat" { # Nat Instance
  ami                         = lookup(var.amis, var.region)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.instance.id
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.nat.id]

  tags = merge(local.common_tags, {
    Name = "bastion-nat"
  })
}

# Control-plane #

resource "aws_instance" "controlplane" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  private_ip             = "10.0.1.10"
  key_name               = aws_key_pair.instance.id
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.kubernetes.id]


  user_data = <<EOT
#!/bin/bash
sudo /usr/bin/apt update
sudo /usr/bin/apt install ifupdown
/bin/echo '#!/bin/bash
if [[ $(sudo /usr/sbin/iptables -t nat -L) != *"MASQUERADE"* ]]; then
  /bin/echo 1 > /proc/sys/net/ipv4/ip_forward
  /usr/sbin/iptables -t nat -A POSTROUTING -s ${var.cidr} -j MASQUERADE
fi
' | sudo /usr/bin/tee /etc/network/if-pre-up.d/nat-setup
sudo chmod +x /etc/network/if-pre-up.d/nat-setup
sudo /etc/network/if-pre-up.d/nat-setup 
  EOT

  tags = merge(local.common_tags, {
    Name = "controlplane"
  })
}


# Worker-Node #
resource "aws_instance" "node1" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.medium"
  private_ip             = "10.0.2.10"
  key_name               = var.company
  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [aws_security_group.kubernetes.id]


  user_data = <<EOT
#!/bin/bash
sudo /usr/bin/apt update
sudo /usr/bin/apt install ifupdown
/bin/echo '#!/bin/bash
if [[ $(sudo /usr/sbin/iptables -t nat -L) != *"MASQUERADE"* ]]; then
  /bin/echo 1 > /proc/sys/net/ipv4/ip_forward
  /usr/sbin/iptables -t nat -A POSTROUTING -s ${var.cidr} -j MASQUERADE
fi
' | sudo /usr/bin/tee /etc/network/if-pre-up.d/nat-setup
sudo chmod +x /etc/network/if-pre-up.d/nat-setup
sudo /etc/network/if-pre-up.d/nat-setup 
  EOT

  tags = merge(local.common_tags, {
    Name = "worker"
  })
}