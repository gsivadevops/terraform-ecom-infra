resource "aws_instance" "bastion" {
  ami           = local.ami_id # getting the ami id from locals
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id] # getting the baston security group id from locals
  subnet_id = local.public_subnet_id # getting the public subnet id from locals for bastion, otherwise it will create in default VPC

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
  )
}