#front end security group
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
