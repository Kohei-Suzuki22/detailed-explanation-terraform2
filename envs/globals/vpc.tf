resource "aws_vpc" "detailed-explanation-terraform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name": "detailed-explanation-terraform"
  }
}

resource "aws_subnet" "detailed-explanation-terraform-subnet-1a" {
  vpc_id = aws_vpc.detailed-explanation-terraform.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    "Name": "detailed-explanation-terraform-subnet-1a"
  }
}

resource "aws_subnet" "detailed-explanation-terraform-subnet-1c" {
  vpc_id = aws_vpc.detailed-explanation-terraform.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    "Name": "detailed-explanation-terraform-subnet-1c"
  }
}