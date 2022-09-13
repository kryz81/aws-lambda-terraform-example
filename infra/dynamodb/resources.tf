resource "aws_dynamodb_table" "table" {
  name         = var.table_name
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "example-table-item" {
  table_name = aws_dynamodb_table.table.name
  hash_key   = aws_dynamodb_table.table.hash_key
  item = jsonencode({
    id        = { S = uuid() },
    content   = { S = "todo item 1" },
    done      = { BOOL = false },
    createdAt = { S = timestamp() }
  })
}
