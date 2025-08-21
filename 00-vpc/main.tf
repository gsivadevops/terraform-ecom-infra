module "vpc" {
  source = "git::https://github.com/gsivadevops/terraform-aws-vpc-module.git?ref=main"  
  project = var.project
  environment = var.environment
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  is_peering_required = true
  
}

#just to print the vpc id in output
output "vpc_id" { # vpc_id - any name
   value = module.vpc.vpc_id 
}

#just to print the public subnet ids in output
output "vpc_public_subnet_ids" { #vpc_public_subnet_ids - any name
  value = module.vpc.public_subnet_ids
}