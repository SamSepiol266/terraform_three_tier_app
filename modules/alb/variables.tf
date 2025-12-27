variable "vpc_id" {
  description = "VPC ID where the ALB security group will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets where the ALB will be deployed"
  type        = list(string)
}
