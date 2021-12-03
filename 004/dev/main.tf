provider "aws" {
  # Configuration options
  region = "us-east-1"
}

#Creating a basic module
module "web_cluster_farm" {
  source      = "./../modules/services/webserver-cluster"
  server_port = 8080
  environment = "development"
  sg-name     = "dev-sg"
  minnodes    = 4
  maxnodes    = 20
  desired     = 5

}