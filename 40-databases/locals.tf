locals{
    ami_id = data.aws_ami.joindevops.id # getting the joindevops (devops-practice) ami id using datasource    
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    mysql_root_password = data.aws_ssm_parameter.mysql_root_password.value
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value    
    database_subnet_id = split ("," , data.aws_ssm_parameter.database_subnet_ids.value)[0] # getting the database subnet id using datasource

    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}