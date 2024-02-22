variable "vpc_id" {
    default = "vpc-0bdeff502932dbc57"
}

variable "project" {
    default = "load-balancer"
}

variable "subnet_ids" {
    default = ["us-east-2a","us-east-2b","us-east-2c"]
}
 
variable "aws_autoscaling_group_mobile" {
    default = "module.asg.asg_mobile_name"
}

variable "aws_autoscaling_group_laptop" {
    default = "module.asg.asg_laptop_name"
}

variable "aws_autoscaling_group_home" {
    default = "module.asg.asg_home`_name"
}