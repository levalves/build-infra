terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "itsseg-terraform-tfstates"
    key    = "build-infra/sg/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region

  #   assume_role {
  #   role_arn = var.role_arn
  # }

  default_tags {
    tags = {
      product     = var.product
      application = var.application
      terraform   = var.terraform
    }
  }
}