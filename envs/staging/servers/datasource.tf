data "terraform_remote_state" "globals" {
  backend = "s3"

  config = {
    bucket = "detailed-explanation-terraform"
    key = "globals/terraform.tfstate"
    region = "ap-northeast-1"
  }

  
}