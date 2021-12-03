variable "users" {
  description = "Create IAM Users"
  type        = list(string)
  default     = ["Neo"]
}

variable "custom_tags" {
  description = "Custom tags to set on the instances"
  type        = map(string)
  default = {
    Environmnet = "development"
    CostCenter  = "Infrastructure"
  }
}