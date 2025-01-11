########### Application #############
variable "region" {}
variable "application" {}
variable "customer_code" {}
variable "security_group_id_bastion"{}
variable "security_group_id_agent_azdevops"{}
variable "security_group_id_agent_azdevops_ubuntu"{}

variable "public_subnet_2a_id" {}

########### VPC #############
variable "vpc_id" {}
variable "public_subnets_id"{}
variable "private_subnets_id"{}
variable "azs" {}

########### TAGs #############
variable "product" {
  default = "levalves"
}

variable "maintenance" {
  default = "no"  
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}