
variable "region" {
  default = "ap-southeast-1"
}

variable "amis" {
  type = map(any)
  default = {
    ap-southeast-1 = "ami-0a72af05d27b49ccb"
  }
}

variable "instance-count" {
  default = 3
}

variable "private-key" {
  default = "jr-dev-mm"
}

variable "public-key" {
  default = "jr-dev-mm.pub"
}

variable "project" {
  default = "jr-dev-mm"

}

variable "ec2-user" {
  default = "ec2-user"
}

variable "vpc-name" {
  default = "JrDevMM"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "public-subnet-1" {
  default = "10.0.1.0/24"
}

variable "public-subnet-2" {
  default = "10.0.2.0/24"
}

variable "public-subnet-3" {
  default = "10.0.3.0/24"
}

variable "private-subnet-1" {
  default = "10.0.4.0/24"
}

variable "private-subnet-2" {
  default = "10.0.5.0/24"
}

variable "private-subnet-3" {
  default = "10.0.6.0/24"
}

variable "rds-private-subnet-1" {
  default = "10.0.7.0/24"
}

variable "rds-private-subnet-2" {
  default = "10.0.8.0/24"
}

variable "rds-private-subnet-3" {
  default = "10.0.9.0/24"
}

variable "zone-a" {
  default = "ap-southeast-1a"
}

variable "zone-b" {
  default = "ap-southeast-1b"
}

variable "zone-c" {
  default = "ap-southeast-1c"
}

variable "env" {
  default = "jr-dev-mm"
}