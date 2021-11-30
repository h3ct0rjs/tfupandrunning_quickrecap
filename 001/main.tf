resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data                   = <<-EOF
            #!/bin/bash
            echo "Hello from DevOps Colombia" >index.html
            nohup busybox httpd -f -p 8080 &
            EOF
  associate_public_ip_address = true
  tags = {
    Name = "${var.name}"
  }

}
