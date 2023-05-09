resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "aws_key_pair" "instance" {
  key_name   = var.company
  public_key = tls_private_key.ssh.public_key_openssh
}

# Create and stores ssh key used creating an EC2 instance
resource "aws_secretsmanager_secret" "secrets_manager" {
  name = var.company
}

resource "aws_secretsmanager_secret_version" "ssh_key" {
  secret_id     = aws_secretsmanager_secret.secrets_manager.id
  secret_string = tls_private_key.ssh.private_key_pem
}