module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
	version = "5.6.0"
  
	create 								 = true
	name 									 = "bastion-host"
  instance_type          = "t3.nano"
	key_name 							 = "bastion-host-${var.region}"
  monitoring             = false
  vpc_security_group_ids = var.security_group_id_bastion
  subnet_id              = var.public_subnet_2a_id
	associate_public_ip_address = true
}

module "ec2_agent_azdevops_ubuntu" {
  source  = "terraform-aws-modules/ec2-instance/aws"
	version = "5.6.0"
  
	create 								 = true
  ami                    = "ami-0b8b44ec9a8f90422"
	name 									 = "agent-azdevops-ubuntu"
  instance_type          = "t3a.small"
	key_name 							 = "agent-azdevops-${var.region}"
  monitoring             = false
  vpc_security_group_ids = var.security_group_id_bastion
  subnet_id              = var.public_subnet_2a_id
	associate_public_ip_address = true
}
