terraform {
  backend "s3" {
    key = "globals/terraform.tfstate"
  }
}
