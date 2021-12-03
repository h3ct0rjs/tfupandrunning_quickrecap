output "users_iam" {
  value = aws_iam_user.users-list
}

output "users_iam_value" {
  value = keys(aws_iam_user.users-list)[*]
}