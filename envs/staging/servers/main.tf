module "servers" {
  source = "../../../modules/servers"

  server_port = var.server_port
}