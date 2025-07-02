output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.pokemon_app.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.pokemon_app.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.pokemon_app.public_dns
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.pokemon_app.private_ip
}