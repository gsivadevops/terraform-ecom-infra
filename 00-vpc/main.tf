module "vpc" {
  source = "git::https://github.com/gsivadevops/terraform-aws-vpc-module.git?ref=main"  
  project = var.project
  environment = var.environment
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  is_peering_required = true
  
}

output "vpc_id" {
   value = module.vpc.vpc_id #just to print the vpc id in output
}