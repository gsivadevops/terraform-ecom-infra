variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "frontend_sg_name" {
    default = "frontend-sg"
}

variable "frontend_sg_description" {
    default = "created sg for frontend instance"
}

variable "bastion_sg_name" {
    default = "bastion-sg"
}

variable "bastion_sg_description" {
    default = "created sg for bastion instance"
}

variable "backend_alb_sg_name" {
    default = "backend-alb-sg"
}

variable "backend_alb_sg_description" {
    default = "created sg for backend alb"
}

variable "vpn_sg_name" {
    default = "vpn-sg"
}

variable "vpn_sg_description" {
    default = "created sg for vpn"
}

#mongodb
variable "mongodb_sg_name" {
    default = "mongodb-sg"
}

variable "mongodb_sg_description" {
    default = "created sg for mongodb"
}

variable "mongodb_ports_vpn" { # just keep as mongodb_ports
    default = [22, 27017]
}

#redis
variable "redis_sg_name" {
    default = "redis-sg"
}

variable "redis_sg_description" {
    default = "created sg for redis"
}

variable "redis_ports_vpn" {
    default = [22, 6379]
}

#mysql
variable "mysql_sg_name" {
    default = "mysql-sg"
}

variable "mysql_sg_description" {
    default = "created sg for mysql"
}

variable "mysql_ports_vpn" {
    default = [22, 3306]
}

#rabbitmq
variable "rabbitmq_sg_name" {
    default = "rabbitmq-sg"
}

variable "rabbitmq_sg_description" {
    default = "created sg for rabbitmq"
}

variable "rabbitmq_ports_vpn" {
    default = [22, 5672]
}



