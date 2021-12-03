provider "aws" {
  # Configuration options
  region = "us-east-1"
}

#Creating a basic module
module "web_cluster_farm" {
  source      = "github.com/h3ct0rjs/asg-alb-mod//services/webserver-cluster?ref=v0.0.3"
  server_port = 8080
  environment = "production"
  sg-name     = "prod-sg"
  minnodes    = 10
  maxnodes    = 20
  desired     = 5
}

output "lb" {
  value = module.web_cluster_farm.alb_dns_name
}