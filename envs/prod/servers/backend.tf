terraform {
  backend "s3" {
    key = "prod/servers/terraform.tfstate"
  }
}
