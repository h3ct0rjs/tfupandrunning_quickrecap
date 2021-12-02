resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  iam_instance_profile        = data.aws_iam_role.ssmrole.name
  associate_public_ip_address = true
  user_data                   = <<-EOF
            #!/bin/bash
            
            echo "Hello from DevOps Colombia" >index.html
            ip addr show eth0 | grep inet | awk '{print $2}' >>index.html
            echo "${data.terraform_remote_state.database.outputs.dbaddress}" >>index.html
            echo "${data.terraform_remote_state.database.outputs.dbport}" >>index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags = {
    Name = terraform.workspace == "default" ? "development" : "production"
  }

}    