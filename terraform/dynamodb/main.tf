resource "aws_dynamodb_table" "pokemon_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = merge(var.tags, {
    Name = var.table_name
  })
}