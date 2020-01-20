provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "itau-data-terraform-cb-pagar"
    key    = "cb-pagar-dev.tfstate"
    region = "us-east-1"
  }
}
