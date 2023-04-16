terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = "AKIARSLG5W7XF6E4MSPW"
  secret_key = "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"
}