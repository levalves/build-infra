######################### STOP/START EC2 #########################
module "eventbridge_stop_ec2" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.2.3"
  
  create_bus = false
  rules = {
    eventbridge-stop-ec2 = {
      description         = "Rules managed by Terraform"
      schedule_expression = "cron(00 22 ? * MON-FRI *)" #Stop EC2 Monday-Friday 19:00 UTC -03:00
    }
  }

  targets = {
    eventbridge-stop-ec2 = [
      {
        name  = "${var.customer_code}-${var.environment}-start-stop-ec2"
        arn   = module.lambda_start_stop_ec2.lambda_function_arn
      }
    ]
  }
}

module "eventbridge_start_ec2" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.2.3"
  
  create_bus = false
  create_role = false # set to false - Role with name default already exists.
  rules = {
    eventbridge-start-ec2 = {
      description         = "Rules managed by Terraform"
      schedule_expression = "cron(30 10 ? * MON-FRI *)" #Start EC2 Monday-Friday 07:30 UTC -03:00
    }
  }

  targets = {
    eventbridge-start-ec2 = [
      {
        name  = "${var.customer_code}-${var.environment}-start-stop-ec2"
        arn   = module.lambda_start_stop_ec2.lambda_function_arn
      }
    ]
  }
}

######################### STOP/START RDS #########################
module "eventbridge_stop_rds" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.2.3"
  
  create_bus = false
  create_role = false # set to false - Role with name default already exists.
  rules = {
    eventbridge-stop-rds = {
      description         = "Rules managed by Terraform"
      schedule_expression = "cron(00 22 ? * MON-FRI *)" #Stop RDS Monday-Friday 19:00 UTC -03:00
    }
  }

  targets = {
    eventbridge-stop-rds = [
      {
        name  = "${var.customer_code}-${var.environment}-start-stop-rds"
        arn   = module.lambda_start_stop_rds.lambda_function_arn
      }
    ]
  }
}

module "eventbridge_start_rds" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.2.3"
  
  create_bus = false
  create_role = false # set to false - Role with name default already exists.
  rules = {
    eventbridge-start-rds = {
      description         = "Rules managed by Terraform"
      schedule_expression = "cron(30 10 ? * MON-FRI *)" #Start RDS Monday-Friday 07:30 UTC -03:00
    }
  }

  targets = {
    eventbridge-start-rds = [
      {
        name  = "${var.customer_code}-${var.environment}-start-stop-rds"
        arn   = module.lambda_start_stop_rds.lambda_function_arn
      }
    ]
  }
}