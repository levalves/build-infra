########### Application #############
variable "region" {}
variable "application" {}
variable "customer_code" {}

########### VPC #############
variable "vpc_id" {}
variable "public_subnets_id"{}
variable "private_subnets_id"{}
variable "azs" {}

########### TAGs #############
variable "product" {
  default = "smartbenefits"
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}