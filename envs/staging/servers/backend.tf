terraform {
  backend "s3" {
    key = "staging/servers/terraform.tfstate"
  }
}
