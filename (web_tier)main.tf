# main.tf in modules/web_tier

variable "vpc_id" {}
variable "public_subnets" {}
variable "web_security_group" {}
variable "app_load_balancer" {}

# Defines the template for our web server instances
resource "aws_launch_template" "web" {
  name_prefix   = "web-server-template"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = var.web_security_group

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from the Web Tier!</h1>" > /var/www/html/index.html
              EOF
  )

  tags = {
    Name = "web-server-template"
  }
}

# Creates the Auto Scaling Group to manage our web servers
resource "aws_autoscaling_group" "web" {
  name                = "web-asg"
  vpc_zone_identifier = var.public_subnets
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  # Attach this ASG to the Load Balancer's target group
  target_group_arns = [var.app_load_balancer]
}
