# main.tf in modules/database_tier

variable "vpc_id" {}
variable "private_subnets" {}
variable "db_security_group" {}
variable "db_subnet_group" {}

# Creates the RDS instance (MySQL in this case)
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = "myappdb"
  username             = "admin"
  password             = "YourSecurePassword123" # In a real project, use a secret manager!
  db_subnet_group_name = var.db_subnet_group
  vpc_security_group_ids = var.db_security_group
  skip_final_snapshot  = true
  publicly_accessible  = false # IMPORTANT: Ensures the DB is not on the internet
}

