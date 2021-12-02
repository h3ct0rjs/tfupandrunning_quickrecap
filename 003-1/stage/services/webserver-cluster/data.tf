data "aws_iam_role" "ssmrole" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}

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

data "terraform_remote_state" "database" {
  backend = "s3"

  config = {
    bucket = "cloudcastteraform"
    key    = "tfupandrunning/datastore/terraform.tfstate"
    region = "us-east-1"
  }

}

data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "defaultsubnets" {
  vpc_id = data.aws_vpc.main.id
}