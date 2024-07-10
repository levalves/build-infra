###### Bastion Host #####
output "security_group_id_bastion" {
  value = module.its_bastion_host_sg.security_group_id
}

output "security_group_name_bastion" {
  value = module.its_bastion_host_sg.security_group_name
}

output "security_group_vpc_id_bastion" {
  value = module.its_bastion_host_sg.security_group_vpc_id
}

###### agent_azdevops Host #####
output "security_group_id_agent_azdevops" {
  value = module.its_agent_azdevops_sg.security_group_id
}

output "security_group_name_agent_azdevops" {
  value = module.its_agent_azdevops_sg.security_group_name
}

output "security_group_vpc_id_agent_azdevops" {
  value = module.its_agent_azdevops_sg.security_group_vpc_id
}

###### agent_azdevops_ubuntu Host #####
output "security_group_id_agent_azdevops_ubuntu" {
  value = module.its_agent_azdevops_ubuntu_sg.security_group_id
}

output "security_group_name_agent_azdevops_ubuntu" {
  value = module.its_agent_azdevops_ubuntu_sg.security_group_name
}

output "security_group_vpc_id_agent_azdevops_ubuntu" {
  value = module.its_agent_azdevops_ubuntu_sg.security_group_vpc_id
}


###### RDS PostgreSQL #####
output "security_group_id_rds" {
  value = module.computed_its_pgsql_rds_sg.security_group_id
}

output "security_group_name_rds" {
  value = module.computed_its_pgsql_rds_sg.security_group_name
}

output "security_group_vpc_id_rds" {
  value = module.computed_its_pgsql_rds_sg.security_group_vpc_id
}

###### Cluster Service #####
output "security_group_id_svc" {
  value = module.computed_its_svc_sg.security_group_id
}

output "security_group_name_svc" {
  value = module.computed_its_svc_sg.security_group_name
}

output "security_group_vpc_id_svc" {
  value = module.computed_its_svc_sg.security_group_vpc_id
}

###### ALB HTTP / HTTPS #####
output "security_group_id_alb" {
  value = module.its_alb_sg.security_group_id
}

output "security_group_name_alb" {
  value = module.its_alb_sg.security_group_name
}

output "security_group_vpc_id_alb" {
  value = module.its_alb_sg.security_group_vpc_id
}
