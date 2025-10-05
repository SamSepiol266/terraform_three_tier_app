# main.tf in modules/app_tier

variable "vpc_id" {}
variable "private_subnets" {}
variable "app_security_group" {}

# Defines the template for our application server instances
resource "aws_launch_template" "app" {
  name_prefix   = "app-server-template"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = var.app_security_group

  # In a real-world scenario, this user data would install your application
  # (e.g., a Node.js, Python, or Java application)
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              # Placeholder for application installation
              echo "Application server started." > /home/ec2-user/status.txt
              EOF
  )

  tags = {
    Name = "app-server-template"
  }
}

# Creates the Auto Scaling Group to manage our application servers
resource "aws_autoscaling_group" "app" {
  name                = "app-asg"
  vpc_zone_identifier = var.private_subnets
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
