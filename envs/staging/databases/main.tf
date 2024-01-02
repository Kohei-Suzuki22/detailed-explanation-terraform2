module "databases" {
  source = "../../../modules/databases"

  db_username = var.db_username
  db_password = var.db_password
}