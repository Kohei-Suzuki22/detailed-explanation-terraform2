module "databases" {
  source = "../../../modules/databases"

  cluster_name = "staging"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  db_username = var.db_username
  db_password = var.db_password
}