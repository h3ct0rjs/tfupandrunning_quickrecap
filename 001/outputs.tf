output "server_ip" {
  value = aws_instance.web.public_ip
  sensitive = false
}

# output "vpc_info" {
#   value = data.aws_vpc.main
# }