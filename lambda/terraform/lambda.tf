module "lambda_start_stop_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.1"

  function_name = "${var.customer_code}-${var.environment}-start-stop-ec2"
  description   = "Lambda managed by Terraform"
  handler       = var.handler_ec2
  runtime       = var.runtime_python
  timeout       = 10
  source_path   = "../lambdas/ec2/"
  create_current_version_allowed_triggers = false
  allowed_triggers = {
    eventbridge-stop-ec2 = {
      service    = "events"
      source_arn = module.eventbridge_stop_ec2.eventbridge_rule_arns["eventbridge-stop-ec2"]
    }
    eventbridge-start-ec2 = {
      service    = "events"
      source_arn = module.eventbridge_start_ec2.eventbridge_rule_arns["eventbridge-start-ec2"]
    }
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.customer_code}-${var.environment}-start-stop-ec2-policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement": [
        {
          "Effect"  : "Allow",
          "Action"  : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ec2:Describe*",
            "ec2:StopInstances",
            "ec2:StartInstances",
            "elasticloadbalancing:Describe*",
            "cloudwatch:ListMetrics",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:Describe*",
            "autoscaling:Describe*"
          ],
          "Resource": "*"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = module.lambda_start_stop_ec2.lambda_function_name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

######################### STOP/START RDS #########################
module "lambda_start_stop_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.1"

  function_name = "${var.customer_code}-${var.environment}-start-stop-rds"
  description   = "Lambda managed by Terraform"
  handler       = var.handler_rds
  runtime       = var.runtime_python
  timeout       = 10
  source_path   = "../lambdas/rds/"
  create_current_version_allowed_triggers = false
  allowed_triggers = {
    eventbridge-stop-rds = {
      service    = "events"
      source_arn = module.eventbridge_stop_rds.eventbridge_rule_arns["eventbridge-stop-rds"]
    }
    eventbridge-start-rds = {
      service    = "events"
      source_arn = module.eventbridge_start_rds.eventbridge_rule_arns["eventbridge-start-rds"]
    }
  }
}

resource "aws_iam_policy" "lambda_rds_policy" {
  name   = "${var.customer_code}-${var.environment}-start-stop-rds-policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement": [
        {
          "Effect"  : "Allow",
          "Action"  : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "cloudwatch:ListMetrics",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:Describe*",
            "rds:DescribeDBInstances",
            "rds:ListTagsForResource",
            "rds:StartDBInstance",
				    "rds:StopDBInstance"
          ],
          "Resource": "*"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_rds_policy_attachment" {
  role       = module.lambda_start_stop_rds.lambda_function_name
  policy_arn = aws_iam_policy.lambda_rds_policy.arn
}