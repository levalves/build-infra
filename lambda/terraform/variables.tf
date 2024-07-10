########### Application #############
variable "region" {}
variable "application" {}
variable "customer_code" {}
variable "environment" {}
variable "runtime_python" {}
variable "handler_ec2" {}
variable "handler_rds" {}

########### TAGs #############
variable "product" {
  default = "smartbenefits"
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}