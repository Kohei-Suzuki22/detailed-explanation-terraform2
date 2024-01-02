# resource "aws_instance" "web-server" {
#   ami = "ami-07c589821f2b353aa"
#   instance_type = "t2.micro"
#   subnet_id = data.terraform_remote_state.globals.outputs.subnet_ids[0]

#   associate_public_ip_address = true
#   availability_zone = "ap-northeast-1a"
# }


resource "aws_launch_configuration" "web-server" {
  image_id = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"


  security_groups = [aws_security_group.web-server.id]

  user_data = <<-EOF
                  #!/bin/bash
                  echo "Hello, World" > index.html
                  nohup busybox httpd -f -p ${var.server_port} &
                 EOF
  
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web-server" {
  launch_configuration = aws_launch_configuration.web-server.name
  vpc_zone_identifier = data.terraform_remote_state.globals.outputs.subnet_ids

  target_group_arns = [aws_lb_target_group.alb.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  instance_refresh {
    strategy = "Rolling"
  }

  tag {
    key = "Name"
    value = "terraform-web-server-asg"
    propagate_at_launch = true
  }
}


resource "aws_lb" "web-server" {
  name = "web-server-alb"
  load_balancer_type = "application"
  subnets = data.terraform_remote_state.globals.outputs.subnet_ids
  security_groups = [aws_security_group.alb.id]
}


resource "aws_lb_listener" "web-server" {
  load_balancer_arn = aws_lb.web-server.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"


    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
  
}

resource "aws_lb_listener_rule" "alb" {
  listener_arn = aws_lb_listener.web-server.arn
  priority = 100
  
  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}

resource "aws_lb_target_group" "alb" {
  name = "web-server-alb-target"
  port = var.server_port
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.globals.outputs.terraform_vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
  
}