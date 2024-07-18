terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {}


resource "aws_s3_bucket" "example" {
  bucket = "tf-jd-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}