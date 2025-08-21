# Strong vpc id in SSM Prama Store
resource "aws_ssm_parameter" "frontend_sg_id" {
  name        = "/${var.project}/${var.environment}/frontend_sg_id" 
  type        = "String"
  value       = module.frontend.sg_id  
}

# Strong bastion sg id in SSM Prama Store
resource "aws_ssm_parameter" "bastion_sg_id" {
  name        = "/${var.project}/${var.environment}/bastion_sg_id" 
  type        = "String"
  value       = module.bastion.sg_id  
}