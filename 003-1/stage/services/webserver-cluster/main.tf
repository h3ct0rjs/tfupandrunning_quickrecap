resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  iam_instance_profile        = data.aws_iam_role.ssmrole.name
  associate_public_ip_address = true
  user_data                   = data.template_file.user-data.rendered
  vpc_security_group_ids      = [aws_security_group.http-sg-instance.id]

  tags = {
    Name = terraform.workspace == "default" ? "development" : "production"
  }

}

data "template_file" "user-data" {
  template = file("user-data.tpl")

  vars = {
    dbaddress  = data.terraform_remote_state.database.outputs.dbaddress
    dbport     = data.terraform_remote_state.database.outputs.dbport
    serverport = var.server_port
  }
}