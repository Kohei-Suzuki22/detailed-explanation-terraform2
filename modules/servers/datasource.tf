data "terraform_remote_state" "globals" {
  backend = "s3"
  config = {
    bucket = "detailed-explanation-terraform"
    key = "globals/terraform.tfstate"
    region = "ap-northeast-1"
  }  
}

data "terraform_remote_state" "databases" {
  backend = "s3"
  config = {
    bucket = "detailed-explanation-terraform"
    key = "staging/databases/terraform.tfstate"
    region = "ap-northeast-1"
  }   
}