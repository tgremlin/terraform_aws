provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = ".//Modules/Networking"
  
  vpc_name = "Kube Test"
  Region   = "us-west-2"
}
