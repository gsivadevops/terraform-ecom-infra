# mongodb instance creation
resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}

# Ansible Integration for mongodb
resource "terraform_data" "mongodb" {  
# Creation of Triggers
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  # Copying the script
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  # Creating the connection to copy the file
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }
 # Script execution
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}

# redis instance creation
resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-redis"
    }
  )
}

# Ansible Integration for redis
resource "terraform_data" "redis" {  
# Creation of Triggers
  triggers_replace = [
    aws_instance.redis.id
  ]
  # Copying the script
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  # Creating the connection to copy the file
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }
 # Script execution
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}

# mysql instance creation
resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_id
  #Role configuration to fetch SSM Param for mysql root password
  iam_instance_profile = " EC2RoletoFetchSSMParams"
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mysql"
    }
  )
}

# Ansible Integration for mysql
resource "terraform_data" "mysql" {  
# Creation of Triggers
  triggers_replace = [
    aws_instance.mysql.id
  ]
  # Copying the script
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  # Creating the connection to copy the file
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }
 # Script execution
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      #"sudo sh /tmp/bootstrap.sh mysql ${var.environment} local.mysql_root_password" 
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

# rabbitmq instance creation
resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}

# Ansible Integration for rabbitmq
resource "terraform_data" "rabbitmq" {  
# Creation of Triggers
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
  # Copying the script
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  # Creating the connection to copy the file
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }
 # Script execution
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
    ]
  }
}