output "table_name" {
  value       = aws_dynamodb_table.pokemon_table.name
}

output "table_arn" {
  value       = aws_dynamodb_table.pokemon_table.arn
}

output "table_id" {
  value       = aws_dynamodb_table.pokemon_table.id
}