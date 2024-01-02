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

  associate_public_ip_address = true

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


resource "aws_security_group" "web-server" {
  name = "web-server"
  vpc_id = data.terraform_remote_state.globals.outputs.terraform_vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "web-server"
  }

}

