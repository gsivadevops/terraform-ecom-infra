locals{
    ami_id = data.aws_ami.joindevops.id # getting the ami id using datasource
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value # getting the ami id using datasource
    public_subnet_id = split ("," , data.aws_ssm_parameter.public_subnet_ids.value)[0] # getting the public subnet id using datasource

    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}