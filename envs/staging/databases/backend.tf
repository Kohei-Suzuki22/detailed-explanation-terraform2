terraform {
  backend "s3" {
    key = "staging/databases/terraform.tfstate"
  }
}