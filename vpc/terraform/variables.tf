########### Application #############
variable "customer_code" {}
variable "region" {}
variable "environment" {}
variable "application" {}

########### VPC #############
variable "azs" {}
variable "vpc_cidr_01" {}
variable "public_subnets_vpc_cidr_01" {}
variable "private_subnets_vpc_cidr_01" {}

########### TAGs #############
variable "product" {
  default = "smartbenefits"
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}