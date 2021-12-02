resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  iam_instance_profile        = data.aws_iam_role.ssmrole.name
  associate_public_ip_address = true
  tags = {
    Name = terraform.workspace == "default" ? "development" : "production"
  }
}    