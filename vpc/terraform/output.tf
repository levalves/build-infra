###### Bastion Host #####
output "vpc_id_01" {
  value = module.its_vpc_01.vpc_id
}

output "public_subnets_vpc_01" {
  value = module.its_vpc_01.public_subnets
}

output "private_subnets_vpc_01" {
  value = module.its_vpc_01.private_subnets
}