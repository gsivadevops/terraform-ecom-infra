# using the module - terraform-aws-ecom-module
module "user" {
    source = "git::https://github.com/gsivadevops/terraform-aws-ecom-module.git?ref=main" 
    component = "user"
    rule_priority = 20
}