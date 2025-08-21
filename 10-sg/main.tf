# frontend security group
module "frontend" {
  source = "git::https://github.com/gsivadevops/terraform-aws-securitygroup-module.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.frontend_sg_name
  sg_description = var.frontend_sg_description
  vpc_id = local.vpc_id # getting the vpc id value from locals
}

output "sg_id" {
    value = module.frontend.sg_id #just to print the frontend sg id in output
}

# bastion security group
module "bastion" {
  source = "git::https://github.com/gsivadevops/terraform-aws-securitygroup-module.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.bastion_sg_name
  sg_description = var.bastion_sg_description
  vpc_id = local.vpc_id # getting the vpc id value from locals
}

# bastion security group rule
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}
