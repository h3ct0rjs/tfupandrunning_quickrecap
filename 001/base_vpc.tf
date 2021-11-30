data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "defaultsubnets" {
  vpc_id = data.aws_vpc.main.id
}