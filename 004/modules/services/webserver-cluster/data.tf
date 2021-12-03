data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "defaultsubnets" {
  vpc_id = data.aws_vpc.main.id
}

data "aws_iam_role" "ssmrole" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}