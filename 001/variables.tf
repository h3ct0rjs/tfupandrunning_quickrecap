variable "name" {
  type        = string
  description = "Name of the EC2 Instance"
  default     = "first-ec2-server"
}

variable "server_port" {
  type = number 
  description = "Server port for ec2 instances"
  default = 8080
}