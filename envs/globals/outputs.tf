output "terraform_vpc_id" {
  description = "The VPC ids of 'terraform_vpc'"
  value = aws_vpc.detailed-explanation-terraform.id
}

output "subnet_ids" {
  description = "The subnet ids in 'terraform_vpc'"
  value = data.aws_subnets.detailed-explanation-terraform-subnets.ids
}