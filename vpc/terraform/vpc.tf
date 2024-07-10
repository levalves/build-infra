module "its_vpc_01" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "5.5.1"
  name                   = "${var.customer_code}-${var.product}-vpc-01"
  cidr                   = var.vpc_cidr_01
  azs                    = var.azs
  private_subnets        = var.private_subnets_vpc_cidr_01
  public_subnets         = var.public_subnets_vpc_cidr_01
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
}