########### Application #############
variable "region" {}
variable "application" {}
variable "customer_code" {}
variable "environment" {}
variable "security_group_id_rds" {}
variable "maintenance" {}

########### VPC #############
variable "vpc_id" {}
variable "private_subnets_id"{}
variable "azs" {}

########## RDS PostgreSQL #############
variable "postgresql_engine" {
  description = "DB ENGINE"
}
variable "postgresql_version" {
  description = "The name of the RDS version"
}

variable "postgresql_instance_type" {}

variable "postgresql_storage_type" {
  description = "The name of the Storage Type"
}

variable "postgresql_allocated_storage" {
  description = "The allocated storage in gigabytes"
}

variable "postgresql_db_name" {}
variable "postgresql_db_name_admin" {}
variable "postgresql_user" {}
variable "postgresql_port" {}
variable "postgresql_parameter_group" {}

########### TAGs #############
variable "product" {
  default = "smartbenefits"
}

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}