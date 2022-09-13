module "db" {
  source     = "./dynamodb"
  table_name = "todo"
}

module "function-get-items" {
  source     = "./lambda"
  region     = var.region
  table_name = module.db.table.name
  table_arn  = module.db.table.arn
}

module "api" {
  source                 = "./apigateway"
  function_get_items_arn = module.function-get-items.function-get-items
}
