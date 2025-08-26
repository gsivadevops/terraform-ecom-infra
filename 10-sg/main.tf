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

#Rule to allow traffic from VPN
#Backend ALB accepting connections from VPN on port no 80
resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

# #mongodb security group
module "mongodb" {
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.mongodb_sg_name
    sg_description =  var.mongodb_sg_description
    vpc_id = local.vpc_id
}

#mongodb sg rule accepting connections from VPN on port no 22, 27017
resource "aws_security_group_rule" "mongodb_vpn" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
}

#redis security group
module "redis" {
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.redis_sg_name
    sg_description =  var.redis_sg_description
    vpc_id = local.vpc_id
}

#redis sg rule accepting connections from VPN on port no 22, 6379
resource "aws_security_group_rule" "redis_vpn" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

#rabbitmq security group
module "rabbitmq" {
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.rabbitmq_sg_name
    sg_description =  var.rabbitmq_sg_description
    vpc_id = local.vpc_id
}

#rabbitmq sg rule accepting connections from VPN on port no 22, 5672
resource "aws_security_group_rule" "rabbitmq_vpn" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

#mysql security group
module "mysql" {
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.mysql_sg_name
    sg_description =  var.mysql_sg_description
    vpc_id = local.vpc_id
}

#mysql sg rule accepting connections from VPN on port no 22, 3306
resource "aws_security_group_rule" "mysql_vpn" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

# catalogue security group
module "catalogue" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.catalogue_sg_name
    sg_description = var.catalogue_sg_description
    vpc_id = local.vpc_id
}

# Catalogue sg rule for vpn ssh
resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

# Catalogue sg rule for bastion
resource "aws_security_group_rule" "catalogue_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

# Catalogue sg rule for vpn http
resource "aws_security_group_rule" "catalogue_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

# Catalogue sg rule for catalogue backend load balancer
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}

# sg rule for catalogue mongodb
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}




