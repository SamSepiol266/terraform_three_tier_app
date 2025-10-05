provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

################################################################################
# Networking - Creates the foundation for our tiers
################################################################################
module "vpc" {
  source = "./modules/vpc"
}

################################################################################
# Security - Defines the firewall rules for each tier
################################################################################
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

################################################################################
# Web Tier - Public facing layer
################################################################################
module "web_tier" {
  source = "./modules/web_tier"

  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnets
  web_security_group  = [module.security_groups.web_sg_id]
  app_load_balancer   = module.load_balancer.app_load_balancer_arn
}


################################################################################
# Application Load Balancer - Distributes traffic
################################################################################
module "load_balancer" {
    source = "./modules/load_balancer"

    vpc_id              = module.vpc.vpc_id
    public_subnets      = module.vpc.public_subnets
    web_security_group  = [module.security_groups.web_sg_id]
}


################################################################################
# Application Tier - The business logic layer
################################################################################
module "app_tier" {
  source = "./modules/app_tier"

  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  app_security_group = [module.security_groups.app_sg_id]
}

################################################################################
# Database Tier - The data storage layer
################################################################################
module "database_tier" {
  source = "./modules/database_tier"

  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  db_security_group  = [module.security_groups.db_sg_id]
  db_subnet_group    = module.vpc.db_subnet_group_name
}

