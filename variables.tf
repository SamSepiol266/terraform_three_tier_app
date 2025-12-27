variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "three-tier-app"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "app_instance_type" {
  default = "t3.micro"
}

variable "app_instance_count" {
  default = 2
}

variable "db_username" {
  default = "app_user"
}

variable "db_password" {
  default = "ChangeMe123!"
}
