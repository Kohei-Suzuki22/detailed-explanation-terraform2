variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type = string
}

variable "remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type = string
}

variable "globals_remote_state_key" {
  description = "The path for the globals remote state in S3"
  type = string
  
}

variable "databases_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type = string
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080
}