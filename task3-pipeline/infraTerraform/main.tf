terraform {                              # terraform version and provider settings
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {                          # AWS provider configuration
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  extra_tag = "extra-tag"
}

resource "aws_instance" "calculate" {       # EC2 instance for calculator + Nginx
  ami           = "ami-011899242bb902164" # EC2 Ubuntu 20.04 LTS // us-east-1
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]
  key_name = "task3pipeline-key"

  vpc_security_group_ids      = [aws_security_group.calc_sg.id]
  associate_public_ip_address = true

 
  user_data = file("${path.module}/user_data.sh")

  tags = {
    extraTag = local.extra_tag
    Name     = "EC2-calculator"
  }
}

resource "aws_security_group" "calc_sg" {
  name        = "calc_sg-sg"
  description = "Security group allowing HTTP access"
  vpc_id      = module.vpc.vpc_id

 
    ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
    extraTag = local.extra_tag
    Name     = "calc-sg"
  }
}
