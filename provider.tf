provider "aws" {
  region     = var.region
  profile = "default"
  shared_credentials_files = [var.aws_credential_file]
}