provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "users-list" {
  count = length(var.users)
  name  = var.users[count.index]
}   