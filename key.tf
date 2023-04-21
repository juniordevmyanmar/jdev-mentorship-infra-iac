resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "aws_key_pair" "instance" {
  key_name   = var.env
  public_key = tls_private_key.ssh.public_key_openssh

  tags = {
    "Name" = var.env
  }
}

# Create and stores ssh key used creating an EC2 instance
resource "aws_secretsmanager_secret" "jr-dev-mm-secret-manager" {
  name = var.env
}

resource "aws_secretsmanager_secret_version" "ssh-key" {
  secret_id     = aws_secretsmanager_secret.jr-dev-mm-secret-manager.id
  secret_string = tls_private_key.ssh.private_key_pem
}