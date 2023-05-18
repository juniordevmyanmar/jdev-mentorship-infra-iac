### AWS ###
variable "region" {
  description = "AWS Region to use for the resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

### AWS ###

### Common ###

### VPC ###

variable "cidr" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of kubernetes subnets inside the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24"] # Kubernets Subnet
}

variable "database_subnets" {
  type        = list(string)
  description = "A list of database subnets inside the VPC"
  default = ["10.0.3.0/24", "10.0.4.0/24" ] # RDS DB Subnet
}

### VPC ###

### EC2 ###

variable "instance_type" {
  description = "Type for EC2 Instance"
  type        = string
  default     = "t2.medium"
}

variable "amis" {
  type = map(any)
  default = {
    ap-southeast-1 = "ami-0a72af05d27b49ccb"
  }
}

variable "no_count" {
  description = "Loop count"
  type        = number
  default     = 3
}

### Resource Tagging ###

variable "name" {
  description = "Naming prefix for resources"
  type        = string
  default     = "JrDevMM"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Junior-Dev-MM"
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
  default     = "Junior Dev Myanmar Batch-1"
}

variable "billing_code" {
  description = "Billing code for resource tagging"
  type        = string
  default     = "ACCT2023"
}

### Resource Tagging ###

