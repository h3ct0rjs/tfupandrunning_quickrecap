locals {
  http_port = 80
  all_ips   = ["0.0.0.0/0"]
  protocol  = "tcp"
}
resource "aws_security_group" "http-sg-instance" {
  name        = var.sg-name
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = local.protocol
    cidr_blocks = local.all_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.all_ips
  }

  tags = {
    Name        = var.sg-name
    Environment = var.environment
  }
}


resource "aws_security_group" "alb-web-farm-sg" {
  name        = "alb-web-sg-${var.environment}"
  description = "Allow HTTP 8080 inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = local.protocol
    cidr_blocks = local.all_ips
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.protocol
    cidr_blocks = local.all_ips
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.all_ips
  }

  tags = {
    Name = "allow_tls"
  }
}
