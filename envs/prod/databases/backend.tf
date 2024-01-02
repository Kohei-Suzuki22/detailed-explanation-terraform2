terraform {
  backend "s3" {
    key = "prod/databases/terraform.tfstate"
  }
}