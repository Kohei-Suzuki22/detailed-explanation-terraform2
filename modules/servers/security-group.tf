resource "aws_security_group" "web-server" {
  name = "${var.cluster_name}-web-server"
  vpc_id = data.terraform_remote_state.globals.outputs.terraform_vpc_id


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


resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"
  vpc_id = data.terraform_remote_state.globals.outputs.terraform_vpc_id

  ingress {
    from_port = 80
    to_port = 80
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
    "Name" : "alb"
  }
}