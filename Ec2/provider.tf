  terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  # backend "s3" {
  #   bucket   = "devopslearning2025-dev"
  #   key      = "practice-ec2"
  #   region   = "us-east-1"
  #   dynamodb_table = "practicing-ec2"
  # }
  backend "s3" {
    bucket   = "practicing-ec2"
    key      = "practice-ec2"
    region   = "us-east-1"
    dynamodb_table = "devopslearning2025-dev"
  }
} 

#provide authentication here (created authentication using aws configure)
provider "aws" {
    region = "us-east-1"
}