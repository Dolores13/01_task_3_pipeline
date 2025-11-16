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
  ami           = "ami-011899242bb902164"   # EC2 Ubuntu 20.04 LTS // us-east-1
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]
  key_name = "task3pipeline-key"

  vpc_security_group_ids      = [aws_security_group.calc_sg.id]
  associate_public_ip_address = true

  monitoring = true                         #Enable detailed monitoring in CloudWatch

  user_data = <<-EOF
#!/bin/bash
set -eux

apt-get update -y
apt-get install -y docker.io git nginx

systemctl enable docker
systemctl start docker
systemctl enable nginx
systemctl start nginx

cd /opt
rm -rf 01_task_3_pipeline
git clone https://github.com/Dolores13/01_task_3_pipeline.git

cd 01_task_3_pipeline/task3-pipeline
docker build -t calculator-app:latest .

docker stop calculator-container || true
docker rm calculator-container || true
docker run -d --restart unless-stopped --name calculator-container -p 9090:9090 calculator-app:latest

cat > /etc/nginx/sites-available/default << 'EONGX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    location / {
        proxy_pass http://127.0.0.1:9090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EONGX

systemctl restart nginx
EOF
  

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
# CloudWatch alarm to monitor high CPU usage on the calculator EC2 instance
resource "aws_cloudwatch_metric_alarm" "cpu_high_calculate" {
  alarm_name          = "calculator-ec2-high-cpu"
  alarm_description   = "Alarm when EC2 CPU usage is too high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300                # 300 seconds = 5 minutes
  statistic           = "Average"
  threshold           = 70                 # Trigger alarm if CPU > 70%
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = aws_instance.calculate.id
  }

  
}

output "calculator_ec2_public_ip" {
  description = "Public IP address of the calculator EC2 instance"
  value       = aws_instance.calculate.public_ip
}

output "calculator_cpu_alarm_name" {
  description = "Name of the CloudWatch CPU alarm for the calculator EC2 instance"
  value       = aws_cloudwatch_metric_alarm.cpu_high_calculate.alarm_name
}
