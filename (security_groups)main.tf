# main.tf in modules/security_groups

variable "vpc_id" {}

# Security Group for the Web Tier (Load Balancer and EC2 Instances)
resource "aws_security_group" "web_sg" {
  name        = "web-tier-sg"
  description = "Allow HTTP/S traffic to web servers"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-tier-sg"
  }
}

# Security Group for the Application Tier
resource "aws_security_group" "app_sg" {
  name        = "app-tier-sg"
  description = "Allow traffic from web tier"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow traffic from Web SG"
    from_port       = 8080 # Example port for the application
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] # IMPORTANT: Only allows from web tier
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-tier-sg"
  }
}

# Security Group for the Database Tier
resource "aws_security_group" "db_sg" {
  name        = "db-tier-sg"
  description = "Allow traffic from app tier"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL/Aurora traffic from App SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id] # IMPORTANT: Only allows from app tier
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-tier-sg"
  }
}

