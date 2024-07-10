terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "itsseg-terraform-tfstates"
    key    = "build-infra/ecs/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      product     = var.product
      application = var.application
      terraform   = var.terraform
    }
  }
}