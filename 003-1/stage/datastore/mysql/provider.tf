terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.67.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "cloudcastteraform"
    key    = "tfupandrunning/datastore/terraform.tfstate"
    region = "us-east-1"
  }
}