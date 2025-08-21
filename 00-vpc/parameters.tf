# Strong vpc id in SSM Prama Store
resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"  # Choose a meaningful parameter name
  type        = "String"
  value       = module.vpc.vpc_id  # VPC is managed by Terraform VPC module
}