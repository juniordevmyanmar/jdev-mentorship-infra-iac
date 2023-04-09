variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-southeast-1 = "ami-0bf97847fcd5c9f57"
  }
}

variable "PRIV_KEY_PATH" {
  default = "jr-dev-mm"
}

variable "PUB_KEY_PATH" {
  default = "jr-dev-mm.pub"
}

variable "USERNAME" {
  default = "ec2-user"
}

variable "VPC_NAME" {
  default = "JrDevMM"
}

variable "VPC_CIDR" {
  default = "192.168.0.0/16"
}

variable "PUB_SUB_CIDR" {
  default = "192.168.1.0/24"
}

variable "PRIV_SUB1_CIDR" {
  default = "192.168.2.0/24"
}

variable "PRIV_SUB2_CIDR" {
  default = "192.168.3.0/24"
}

variable "ZONE1" {
  default = "ap-southeast-1a"
}

variable "ZONE2" {
  default = "ap-southeast-1b"
}

variable "ZONE3" {
  default = "ap-southeast-1c"
}

variable "NAME" {
  default = "jr-dev-mm"
}

variable "PROJECT" {
  default = "JuniorDev Myanmar"
}