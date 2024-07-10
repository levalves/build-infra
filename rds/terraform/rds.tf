module "db_smartbenefits" {
  source                              = "terraform-aws-modules/rds/aws"
  version                             = "6.4.0"
  identifier                          = "${var.customer_code}-${var.environment}-${var.product}"
  engine                              = var.postgresql_engine
  engine_version                      = var.postgresql_version
  instance_class                      = var.postgresql_instance_type
  storage_type                        = var.postgresql_storage_type
  allocated_storage                   = var.postgresql_allocated_storage
  db_name                             = var.postgresql_db_name
  username                            = var.postgresql_user
  port                                = var.postgresql_port
  iam_database_authentication_enabled = true
  maintenance_window                  = "Mon:00:00-Mon:03:00"
  backup_window                       = "03:00-06:00"
  create_db_subnet_group              = true
  subnet_ids                          = var.private_subnets_id
  family                              = var.postgresql_parameter_group
  vpc_security_group_ids              = [var.security_group_id_rds]
  deletion_protection                 = false
  db_subnet_group_use_name_prefix     = false

  create_db_parameter_group           = true
  parameter_group_use_name_prefix     = false
  parameter_group_name                = "${var.customer_code}-${var.environment}-${var.product}-postgresql-16-1"  

  parameters = [
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
}