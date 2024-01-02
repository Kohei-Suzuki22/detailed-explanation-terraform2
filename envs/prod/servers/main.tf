module "servers" {
  source = "../../../modules/servers"

  cluster_name = "prod"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  databases_remote_state_key = "prod/databases/terraform.tfstate"
  server_port = var.server_port
  instance_type = "t2.micro"
  autoscaling_min_size = 2
  autoscaling_max_size = 2
}


resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  autoscaling_group_name = module.servers.autoscaling_group_name
  min_size = 2
  max_size = 4
  desired_capacity = 4
  time_zone = "Asia/Tokyo"
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scal-in-at-night"
  autoscaling_group_name = module.servers.autoscaling_group_name
  min_size = 2
  max_size = 4
  desired_capacity = 2
  time_zone = "Asia/Tokyo"
  recurrence = "0 17 * * *"
}