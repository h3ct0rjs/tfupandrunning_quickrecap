variable "server_port" {
  type        = number
  description = "The Server Port Number"
}

variable "environment" {
  type        = string
  description = "Environment specification"
}

variable "sg-name" {
  type        = string
  description = "Security Group Name"
}

variable "minnodes" {
  type        = number
  description = "minimun number for the autoscaling group"

}

variable "maxnodes" {
  type        = number
  description = "maximum number for the autoscaling group"

}

variable "desired" {
  type        = number
  description = "desired capacity nodes"
}
