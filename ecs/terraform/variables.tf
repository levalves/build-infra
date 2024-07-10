########### Application #############
variable "region" {}
variable "application" {}
variable "customer_code" {}

########### TAGs #############
variable "product" {
  default = "smartbenefits"
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}