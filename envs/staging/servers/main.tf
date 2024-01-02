module "servers" {
  source = "../../../modules/servers"

  cluster_name = "staging"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  databases_remote_state_key = "staging/databases/terraform.tfstate"
  server_port = var.server_port
  instance_type = "t2.micro"
  autoscaling_min_size = 2
  autoscaling_max_size = 2
}