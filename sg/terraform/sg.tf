module "its_bastion_host_sg" {
  source          = "terraform-aws-modules/security-group/aws"
  version         = "5.1.0"
  name            = "${var.customer_code}-${var.product}-bastion-host-sg"
  vpc_id          = var.vpc_id
  use_name_prefix = false

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "179.191.112.132/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "201.91.151.122/32"
    }    
  ]
  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = "0.0.0.0/0" 
    }
  ]
}

module "its_agent_azdevops_sg" {
  source          = "terraform-aws-modules/security-group/aws"
  version         = "5.1.0"
  name            = "${var.customer_code}-${var.product}-agent-azdevops-sg"
  vpc_id          = var.vpc_id
  use_name_prefix = false

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "179.191.112.132/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "201.91.151.122/32"
    }    
  ]
  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = "0.0.0.0/0" 
    }
  ]
}

module "its_agent_azdevops_ubuntu_sg" {
  source          = "terraform-aws-modules/security-group/aws"
  version         = "5.1.0"
  name            = "${var.customer_code}-${var.product}-agent-azdevops-ubuntu-sg"
  vpc_id          = var.vpc_id
  use_name_prefix = false

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "179.191.112.132/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "201.91.151.122/32"
    }    
  ]
  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = "0.0.0.0/0" 
    }
  ]
}

module "computed_its_pgsql_rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  use_name_prefix = false
  
  name        = "${var.customer_code}-${var.product}-pgsql-rds-sg"
  description = "Security Group managed by Terraform"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule            = "postgresql-tcp"
      source_security_group_id = module.its_bastion_host_sg.security_group_id
    },
    {
      rule            = "postgresql-tcp"
      source_security_group_id = module.its_alb_sg.security_group_id
    },
    {
      rule            = "postgresql-tcp"
      source_security_group_id = module.computed_its_svc_sg.security_group_id
    }    
  ]
  number_of_computed_ingress_with_source_security_group_id = 3

  computed_egress_with_source_security_group_id = [
    {
      rule            = "all-all"
      source_security_group_id = module.its_bastion_host_sg.security_group_id
    }  
  ]
  number_of_computed_egress_with_source_security_group_id = 1
}

module "its_alb_sg" {
  source          = "terraform-aws-modules/security-group/aws"
  version         = "5.1.0"
  name            = "${var.customer_code}-${var.product}-alb-sg"
  vpc_id          = var.vpc_id
  use_name_prefix = false

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      # cidr_blocks = "179.191.112.132/32"
      cidr_blocks = "0.0.0.0/0"

    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      # cidr_blocks = "201.91.151.122/32"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [{
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  cidr_blocks = "0.0.0.0/0" }]

}

module "computed_its_svc_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  use_name_prefix = false
  
  name        = "${var.customer_code}-${var.product}-svc-sg"
  description = "Security Group managed by Terraform"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule            = "all-all"
      source_security_group_id = module.its_alb_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
