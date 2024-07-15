  terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {
    bucket   = "practicing-terraform"
    #bucket   = "Expense-Jenkins"
    #key      = "expense-terraform-jenkins"
    key      = "jenkins"
    region   = "us-east-1"
    dynamodb_table = "devopslearning2025-practicing"
    #dynamodb_table = "devopslearning2025-jenkins"
  }
}

#provide authentication here (created authentication using aws configure)
provider "aws" {
    region = "us-east-1"
}