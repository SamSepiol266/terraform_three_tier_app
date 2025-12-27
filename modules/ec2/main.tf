resource "aws_security_group" "app_sg" {
  name   = "${var.project_name}-app-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow HTTP from ALB"
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
}

resource "aws_instance" "app" {
  count                       = var.instance_count
  ami                         = data.aws_ami.latest.id
  instance_type               = var.instance_type
  subnet_id                   = element(var.private_subnets, count.index % length(var.private_subnets))
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl enable nginx
              systemctl start nginx
              echo "Hello from App Server $(hostname)" > /usr/share/nginx/html/index.html
              EOF

  tags = { Name = "${var.project_name}-app-${count.index + 1}" }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

output "instance_ids" { value = aws_instance.app[*].id }
output "private_ips"  { value = aws_instance.app[*].private_ip }
output "app_sg_id"    { value = aws_security_group.app_sg.id }
