output "instance_ip_addr" {
    value = aws_instance.calculate.private_ip
}

output "calculator_ec2_public_ip" {
  description = "Public IP address of the calculator EC2 instance"
  value       = aws_instance.calculate.public_ip
}

output "calculator_cpu_alarm_name" {
  description = "Name of the CloudWatch CPU alarm for the calculator EC2 instance"
  value       = aws_cloudwatch_metric_alarm.cpu_high_calculate.alarm_name
}