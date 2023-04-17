
resource "aws_security_group" "jdm-public-sg" {
  name        = "jdm-public-sg"
  description = "Allow SSH Connection from Outside"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jdm-public-sg"
  }
}

resource "aws_security_group" "jdm-private-sg" {
  name        = "jdm-private-sg"
  description = "Allow Only from Public Subnet"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow All Traffic only from jdm-public-sg
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.jdm-public-sg.id]
  }

  tags = {
    Name = "jdm-private-sg"
  }
}
