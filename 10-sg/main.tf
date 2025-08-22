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

# backend security group
module "backend_alb" {
  source = "git::https://github.com/gsivadevops/terraform-aws-securitygroup-module.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.backend_alb_sg_name
  sg_description = var.backend_alb_sg_description
  vpc_id = local.vpc_id # getting the vpc id value from locals
}

# backend alb security group rule
# backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

#vpn
module "vpn" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.vpn_sg_name
    sg_description =  var.vpn_sg_description
    vpc_id = local.vpc_id
}

#VPN ports 22, 443, 1194, 943
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

#Backend ALB accepting connections from VPN on port no 80
resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

