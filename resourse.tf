provider "aws" {
  region  = "us-east-1"
}
module "asg" {
    source = "./modules/autoscaling"
}


module "lb" {
    source = "./modules/loadbalancer"
}
