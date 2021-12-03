output "users_iam" {
  value = aws_iam_user.users-list[*].arn
}