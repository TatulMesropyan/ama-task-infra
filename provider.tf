provider "aws" {
  region                   = var.region
  profile                  = "default"
  shared_credentials_files = [var.aws_credential_file]
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
  backend "s3" {
    bucket = "ama-test-task-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
