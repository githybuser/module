provider "aws" {
  region = "us-east-2"
}

#tg group

resource "aws_lb_target_group" "home-tg-grp" {
    health_check {
        path = "/"
    }
    name = "${var.project}-home-tg"
    port = 80
    protocol = "hTTP"
    vpc_id = var.vpc_id
}

resource "aws_lb_target_group" "laptop-tg-grp" {
    health_check {
        path = "/laptop"
    }
    name = "${var.project}-home-tg"
    port = 80
    protocol = "hTTP"
    vpc_id = var.vpc_id
}

resource "aws_lb_target_group" "mobile-tg-grp" {
    health_check {
        path = "/mobile"
    }
    name = "${var.project}-home-tg"
    port = 80
    protocol = "hTTP"
    vpc_id = var.vpc_id
}

#loadbalancer

resource "aws_lb" "test" {
    name = "${var.project}-laptop-tg"
    load-balancer_type = "application"
    security_groups = "sg-0ea5e5a448dcab1d7"
    subnets = var.subnet_ids
}

#listner-load-balancer 

resource "aws_lb_listener" "load-balancer-listner" {
    port = 80
    protocol = "HTTP"
    load_balancer-arn = aws_lb.test.arn
    default_action {
        type = "forward"
        forward = aws_lb_target_group.home-tg-grp.arn
    }
}

#listner for laptop and mobile

resource "aws_lb_listener_rule" "laptop-rule" {
    listener_arn = aws_lb_listener.load-balancer-listner.arn
    priority = 101
    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.laptop-tg-grp.arn
    }
    condition {
        path_pattern {
            value = ["/laptop/*"]
        }
    }
}

resource "aws_lb_listener_rule" "mobile-rule" {
    listener_arn = aws_lb_listener.load-balancer-listner.arn
    priority = 102
    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.mobile-tg-grp.arn
    }
    condition {
        path_pattern {
            value = ["/mobile/*"]
        }
    }
}

#autoscaling attachment

resource "aws_autoscaling_attachment" "home-attachment" {
    autoscaling_group_name = var.aws_autoscaling_group_home
    lb_target_group_arn    = aws_lb_target_group.home-tg-grp.arn
}

resource "aws_autoscaling_attachment" "laptop-attachment" {
    autoscaling_group_name = var.aws_autoscaling_group_laptop
    lb_target_group_arn    = aws_lb_target_group.laptop-tg-grp.arn
}

resource "aws_autoscaling_attachment" "mobile-attachment" {
    autoscaling_group_name = var.aws_autoscaling_group_mobile
    lb_target_group_arn    = aws_lb_target_group.mobile-tg-grp.arn
}