provider "aws" {
  region = "us-east-1"
}

locals {

  common_tags = {
    Owner      = "team-infra"
    DeployedBy = "Terraform"
  }
}
resource "aws_iam_user" "users-list" {
  for_each = toset(var.users)
  name     = each.value

  tags = merge(local.common_tags, var.custom_tags)

}   