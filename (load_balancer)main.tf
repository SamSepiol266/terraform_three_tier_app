# main.tf in modules/load_balancer

variable "vpc_id" {}
variable "public_subnets" {}
variable "web_security_group" {}

# Create the Application Load Balancer itself
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.web_security_group
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "App-LB"
  }
}

# Create a Target Group for the LB to send traffic to
resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
  }
}

# Create a Listener to check for incoming connections on port 80
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

