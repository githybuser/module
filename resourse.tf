module "asg" {
    source = "./modules/autoscaling"
}


module "lb" {
    source = "./modules/loadbalancer"
}
