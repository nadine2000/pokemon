output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.ec2.public_dns
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.dynamodb.table_arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.pokemon_vpc.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.pokemon_sg.id
}