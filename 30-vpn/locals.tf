locals{
    ami_id = data.aws_ami.openvpn.id # getting the ami id using datasource
    vpn_sg_id = data.aws_ssm_parameter.vpn_sg_id.value # getting the vpn sg id using datasource
    public_subnet_id = split ("," , data.aws_ssm_parameter.public_subnet_ids.value)[0] # getting the public subnet id using datasource

    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}