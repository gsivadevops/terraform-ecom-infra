# DB's 
  # MongoDB
    # MongoDB security group
      module "mongodb" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.mongodb_sg_name
          sg_description = var.mongodb_sg_description
          vpc_id = local.vpc_id
      }  

    # MongoDB Security group rule for VPN, Bastion, Catalogue, User -- accepting connections from VPN/Bastion on port no 22, 27017
      resource "aws_security_group_rule" "mongodb_vpn" {
        count = length(var.mongodb_ports)
        type              = "ingress"
        from_port         = var.mongodb_ports[count.index]
        to_port           = var.mongodb_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.mongodb.sg_id
      }

      resource "aws_security_group_rule" "mongodb_bastion" {
        count = length(var.mongodb_ports)
        type              = "ingress"
        from_port         = var.mongodb_ports[count.index]
        to_port           = var.mongodb_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.mongodb.sg_id
      }

      resource "aws_security_group_rule" "mongodb_catalogue" {
        type              = "ingress"
        from_port         = 27017
        to_port           = 27017
        protocol          = "tcp"
        source_security_group_id = module.catalogue.sg_id
        security_group_id = module.mongodb.sg_id
      }

      resource "aws_security_group_rule" "mongodb_user" {
        type              = "ingress"
        from_port         = 27017
        to_port           = 27017
        protocol          = "tcp"
        source_security_group_id = module.user.sg_id
        security_group_id = module.mongodb.sg_id
      }

  # Redis 
    # Redis security group
      module "redis" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.redis_sg_name
          sg_description =  var.redis_sg_description
          vpc_id = local.vpc_id
      }

    # Redis Security Rule for VPN, Bastion, User, Cart  -- accepting connections from VPN/Bastion on port no 22, 6379
      resource "aws_security_group_rule" "redis_vpn" {
        count = length(var.redis_ports)
        type              = "ingress"
        from_port         = var.redis_ports[count.index]
        to_port           = var.redis_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.redis.sg_id
      }

      resource "aws_security_group_rule" "redis_bastion" {
        count = length(var.redis_ports)
        type              = "ingress"
        from_port         = var.redis_ports[count.index]
        to_port           = var.redis_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.redis.sg_id
      }

      resource "aws_security_group_rule" "redis_user" {
        type              = "ingress"
        from_port         = 6379
        to_port           = 6379
        protocol          = "tcp"
        source_security_group_id = module.user.sg_id
        security_group_id = module.redis.sg_id
      }

      resource "aws_security_group_rule" "redis_cart" {
        type              = "ingress"
        from_port         = 6379
        to_port           = 6379
        protocol          = "tcp"
        source_security_group_id = module.cart.sg_id
        security_group_id = module.redis.sg_id
      }
  
  # MySQL
    # MySQL security group
      module "mysql" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.mysql_sg_name
          sg_description =  var.mysql_sg_description
          vpc_id = local.vpc_id
      }

    # MYSQL Security Group Rule for VPN, Bastion, Shipping -- accepting connections from VPN/Bastion on port no 22, 3306
      resource "aws_security_group_rule" "mysql_vpn" {
        count = length(var.mysql_ports)
        type              = "ingress"
        from_port         = var.mysql_ports[count.index]
        to_port           = var.mysql_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.mysql.sg_id
      }

      resource "aws_security_group_rule" "mysql_bastion" {
        count = length(var.mysql_ports)
        type              = "ingress"
        from_port         = var.mysql_ports[count.index]
        to_port           = var.mysql_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.mysql.sg_id
      }

      resource "aws_security_group_rule" "mysql_shipping" {
        type              = "ingress"
        from_port         = 3306
        to_port           = 3306
        protocol          = "tcp"
        source_security_group_id = module.shipping.sg_id
        security_group_id = module.mysql.sg_id
      }
  
  # RabbitMQ
    # RabbitMQ security group
      module "rabbitmq" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.rabbitmq_sg_name
          sg_description =  var.rabbitmq_sg_description
          vpc_id = local.vpc_id
      }

    # RabbitMQ security group Rule for VPN, Bastion, Payment -- accepting connections from VPN/Bastion on port no 22, 5672
      resource "aws_security_group_rule" "rabbitmq_vpn" {
        count = length(var.rabbitmq_ports)
        type              = "ingress"
        from_port         = var.rabbitmq_ports[count.index]
        to_port           = var.rabbitmq_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.rabbitmq.sg_id
      }

      resource "aws_security_group_rule" "rabbitmq_bastion" {
        count = length(var.rabbitmq_ports)
        type              = "ingress"
        from_port         = var.rabbitmq_ports[count.index]
        to_port           = var.rabbitmq_ports[count.index]
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.rabbitmq.sg_id
      }

      resource "aws_security_group_rule" "rabbitmq_payment" {
        type              = "ingress"
        from_port         = 5672
        to_port           = 5672
        protocol          = "tcp"
        source_security_group_id = module.payment.sg_id
        security_group_id = module.rabbitmq.sg_id
      }

# Backend Load balancer
  # Backend Load balancer Secuirity group
    module "backend_alb" {
        #source = "../../terraform-aws-securitygroup"
        source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
        project = var.project
        environment = var.environment

        sg_name = var.backend_alb_sg_name
        sg_description = var.backend_alb_sg_description
        vpc_id = local.vpc_id
    }

  # Backend ALB seucrity group rule
    resource "aws_security_group_rule" "backend_alb_vpn" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.vpn.sg_id
      security_group_id = module.backend_alb.sg_id
    }

    resource "aws_security_group_rule" "backend_alb_bastion" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.bastion.sg_id
      security_group_id = module.backend_alb.sg_id
    }

    resource "aws_security_group_rule" "backend_alb_frontend" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.frontend.sg_id
      security_group_id = module.backend_alb.sg_id
    }

    resource "aws_security_group_rule" "backend_alb_cart" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.cart.sg_id
      security_group_id = module.backend_alb.sg_id
    }

    resource "aws_security_group_rule" "backend_alb_shipping" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.shipping.sg_id
      security_group_id = module.backend_alb.sg_id
    }

    resource "aws_security_group_rule" "backend_alb_payment" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.payment.sg_id
      security_group_id = module.backend_alb.sg_id
    }  

# BE Components
  # Catalogue
    # Catalogue Security Group
      module "catalogue" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.catalogue_sg_name
          sg_description = var.catalogue_sg_description
          vpc_id = local.vpc_id
      }

    # Catalogue Security Group Rule for VPN, Bastion, BE ALB-- accepting connections from VPN/Bastion on port no 22, 8080
      resource "aws_security_group_rule" "catalogue_vpn_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.catalogue.sg_id
      }

      resource "aws_security_group_rule" "catalogue_bastion_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.catalogue.sg_id
      }

      resource "aws_security_group_rule" "catalogue_vpn_http" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.catalogue.sg_id
      }

      resource "aws_security_group_rule" "catalogue_backend_alb" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.backend_alb.sg_id
        security_group_id = module.catalogue.sg_id
      }

  # User
    # User Security Group
      module "user" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.user_sg_name
          sg_description = var.user_sg_description
          vpc_id = local.vpc_id
      }

    # User Security Group Rule for VPN, Bastion, BE ALB-- accepting connections from VPN/Bastion on port no 22, 8080
      resource "aws_security_group_rule" "user_vpn_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.user.sg_id
      }

      resource "aws_security_group_rule" "user_bastion_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.user.sg_id
      }

      resource "aws_security_group_rule" "user_vpn_http" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.user.sg_id
      }

      resource "aws_security_group_rule" "user_backend_alb" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.backend_alb.sg_id
        security_group_id = module.user.sg_id
      }

  # Cart
    # Cart Security Group 
      module "cart" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.cart_sg_name
          sg_description = var.cart_sg_description
          vpc_id = local.vpc_id
      }

    # Cart Security Group Rule for VPN, Bastion, BE ALB-- accepting connections from VPN/Bastion on port no 22, 8080
      resource "aws_security_group_rule" "cart_vpn_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.cart.sg_id
      }

      resource "aws_security_group_rule" "cart_bastion_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.cart.sg_id
      }

      resource "aws_security_group_rule" "cart_vpn_http" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.cart.sg_id
      }

      resource "aws_security_group_rule" "cart_backend_alb" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.backend_alb.sg_id
        security_group_id = module.cart.sg_id
      }
  
  # Shipping
    # Shipping Security Group 
      module "shipping" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.shipping_sg_name
          sg_description = var.shipping_sg_description
          vpc_id = local.vpc_id
      }

    # Shipping Security Group Rule for VPN, Bastion, BE ALB-- accepting connections from VPN/Bastion on port no 22, 8080
      resource "aws_security_group_rule" "shipping_vpn_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.shipping.sg_id
      }

      resource "aws_security_group_rule" "shipping_bastion_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.shipping.sg_id
      }

      resource "aws_security_group_rule" "shipping_vpn_http" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.shipping.sg_id
      }

      resource "aws_security_group_rule" "shipping_backend_alb" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.backend_alb.sg_id
        security_group_id = module.shipping.sg_id
      }  

  # Payment
    # Payment Security Group
      module "payment" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.payment_sg_name
          sg_description = var.payment_sg_description
          vpc_id = local.vpc_id
      }

    # Payment Security Group Rule for VPN, Bastion, BE ALB-- accepting connections from VPN/Bastion on port no 22, 8080
      resource "aws_security_group_rule" "payment_vpn_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.payment.sg_id
      }

      resource "aws_security_group_rule" "payment_bastion_ssh" {
        type              = "ingress"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        source_security_group_id = module.bastion.sg_id
        security_group_id = module.payment.sg_id
      }

      resource "aws_security_group_rule" "payment_vpn_http" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.vpn.sg_id
        security_group_id = module.payment.sg_id
      }

      resource "aws_security_group_rule" "payment_backend_alb" {
        type              = "ingress"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        source_security_group_id = module.backend_alb.sg_id
        security_group_id = module.payment.sg_id
      }

# Frontend
  # Frontend Secuirity group for instance
    module "frontend" {
        #source = "../../terraform-aws-securitygroup"
        source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
        project = var.project
        environment = var.environment

        sg_name = var.frontend_sg_name
        sg_description = var.frontend_sg_description
        vpc_id = local.vpc_id
    }

  # Frontend seucrity group rule for instance
    resource "aws_security_group_rule" "frontend_vpn" {
      type              = "ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      source_security_group_id = module.vpn.sg_id
      security_group_id = module.frontend.sg_id
    }

    resource "aws_security_group_rule" "frontend_bastion" {
      type              = "ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      source_security_group_id = module.bastion.sg_id
      security_group_id = module.frontend.sg_id
    }

    resource "aws_security_group_rule" "frontend_frontend_alb" {
      type              = "ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      source_security_group_id = module.frontend_alb.sg_id
      security_group_id = module.frontend.sg_id
    }
  
  # Frontend Load balancer
    # Frontend Load balancer Secuirity group
      module "frontend_alb" {
          #source = "../../terraform-aws-securitygroup"
          source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
          project = var.project
          environment = var.environment

          sg_name = var.frontend_alb_sg_name
          sg_description = var.frontend_alb_sg_description
          vpc_id = local.vpc_id
      }  

    # Frontend ALB seucrity group rule
      resource "aws_security_group_rule" "frontend_alb_http" {
        type              = "ingress"
        from_port         = 80
        to_port           = 80
        protocol          = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = module.backend_alb.sg_id
      }

      resource "aws_security_group_rule" "frontend_alb_https" {
        type              = "ingress"
        from_port         = 443
        to_port           = 443
        protocol          = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = module.frontend_alb.sg_id
      }

# VPN
  # VPN Secuirity group
    module "vpn" {
        #source = "../../terraform-aws-securitygroup"
        source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
        project = var.project
        environment = var.environment

        sg_name = var.vpn_sg_name
        sg_description =  var.vpn_sg_description
        vpc_id = local.vpc_id
    }  

  # VPN Security group rule for ports 22, 443, 1194, 943
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

#Bastion
  # Bastion Secuirity group
    module "bastion" {
      #source = "../../terraform-aws-securitygroup"
      source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
      project = var.project
      environment = var.environment

      sg_name = var.bastion_sg_name
      sg_description = var.bastion_sg_description
      vpc_id = local.vpc_id
    }
    
  # Bastion Security group rule
    resource "aws_security_group_rule" "bastion_laptop" {
      type              = "ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      security_group_id = module.bastion.sg_id
    }
