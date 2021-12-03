variable "users" {
  description = "Create IAM Users"
  type        = list(string)
  default     = ["Neo", "Trinity", "Morfeo"]
}