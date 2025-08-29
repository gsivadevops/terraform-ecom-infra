# using the module - terraform-aws-ecom-module
module "component" {
    for_each = var.components
    source = "git::https://github.com/gsivadevops/terraform-aws-ecom-module.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}