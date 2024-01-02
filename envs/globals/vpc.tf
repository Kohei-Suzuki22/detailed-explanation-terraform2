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


resource "aws_internet_gateway" "detailed-explanation-terraform" {
  vpc_id = aws_vpc.detailed-explanation-terraform.id

  tags = {
    "Name" = "detailed-explanation-terraform-igw"
  }
}

resource "aws_route_table" "detailed-explanation-terraform-route-table" {
  vpc_id = aws_vpc.detailed-explanation-terraform.id
  tags = {
    "Name" = "detailed-explanation-terraform-route-table"
  }
}


resource "aws_route" "detailed-explanation-terraform" {
  route_table_id = aws_route_table.detailed-explanation-terraform-route-table.id
  # 送信先
  destination_cidr_block = "0.0.0.0/0"
  # ターゲット
  gateway_id = aws_internet_gateway.detailed-explanation-terraform.id
}


resource "aws_route_table_association" "detailed-explanation-terraform-subnet-1a" {
  route_table_id = aws_route_table.detailed-explanation-terraform-route-table.id
  subnet_id = aws_subnet.detailed-explanation-terraform-subnet-1a.id
}

resource "aws_route_table_association" "detailed-explanation-terraform-subnet-1c" {
  route_table_id = aws_route_table.detailed-explanation-terraform-route-table.id
  subnet_id = aws_subnet.detailed-explanation-terraform-subnet-1c.id
}

data "aws_subnets" "detailed-explanation-terraform-subnets" {
  filter {
    name = "vpc-id"
    values = [aws_vpc.detailed-explanation-terraform.id]
  }
}