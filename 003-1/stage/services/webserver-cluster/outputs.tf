output "server_ip" {
    value = aws_instance.web.public_ip
}