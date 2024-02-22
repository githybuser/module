provider "aws" {
  region = "us-east-2"
}

#template congiguration

resource "aws_launch_configuration" "home-conff" {
  name = "${var.project}-home-conf"
  image_id      =  var.image_id 
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = "data.aws_security_group_rule.my-data-sg-grp.id"
  user_data = <<-EOF
            #!/bin/bash
            yum install httpd -y
            echo "<h1> Hello World, Welcome to Cloudblitz" > /var/www/html/index.html
            systemctl start httpd
            systemctl enable httpd
            EOF

}
resource "aws_launch_configuration" "laptop-conff" {
    name = "${var.project}-laptop-conf"
    image_id      =  var.image_id 
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = "data.aws_security_group_rule.my-data-sg-grp.id"
    user_data = <<-EOF
            #!/bin/bash
            yum install httpd -y
            echo "<h1> Hello World, Welcome to laptop section" > /var/www/html/index.html
            systemctl start httpd
            systemctl enable httpd
            EOF

}
  resource "aws_launch_configuration" "mobile-conff" {
    name = "${var.project}-laptop-conf"
    image_id      =  var.image_id 
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = "data.aws_security_group_rule.my-data-sg-grp.id"
    user_data = <<-EOF
            #!/bin/bash
            yum install httpd -y
            echo "<h1> Hello World, Welcome to mobile section" > /var/www/html/index.html
            systemctl start httpd
            systemctl enable httpd
            EOF

}



#data block for security grp

data "aws_security_group" "my-data-sg-grp" {
    name = "launch-wizard-3"
    vpc_id = "vpc-0bdeff502932dbc57"
}

resource "aws_security_group_rule" "allow-ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = "0.0.0.0/0"
    security_group_id = ["data.aws_security_group_rule.my-data-sg-grp.id","sg-0ea5e5a448dcab1d7"]
}

#autoscaling group 

resource "aws_autoscaling_group" "home-autoscale-grp" {
    name = "${var.project}-home-auto-scaling-grp"
    max_size = 5
    min_size = 2
    availability_zones = us-east-2a
    desired_capacity_type = 3
    launch_configuration = aws_launch_configuration.home-conff.name
}

resource "aws_autoscaling_group" "laptop-autoscale-grp" {
    name = "${var.project}-laptop-auto-scaling-grp"
    max_size = 5
    min_size = 2
    availability_zones = us-east-2a
    desired_capacity_type = 3
    launch_configuration = aws_launch_configuration.laptop-conff.name
}

resource "aws_autoscaling_group" "mobile-autoscale-grp" {
    name = "${var.project}-mobile-auto-scaling-grp"
    max_size = 5
    min_size = 2
    availability_zones = us-east-2a
    desired_capacity_type = 3
    launch_configuration = aws_launch_configuration.mobile-conff.name
}

#autoscaling policy

#home-policy

resource "aws_autoscaling_policy" "home-policy" {
    autoscaling_group_name = aws_autoscaling_group.home-autoscale-grp.name
    name                   = "${var.project}-home-policy"
    policy_type            = "PredictiveScaling"
    predictive_scaling_configuration {
      metric_specification {
        target_value = 60
        predefined_load_metric_specification {
          predefined_metric_type = "ASGTotalCPUUtilization"
          #resource_label         = "app/cloudblitz-lb/778d41231b141a0f/targetgroup/cloudblitz-tg-mobile/943f017f100becff"
        }
        customized_scaling_metric_specification {
          metric_data_queries {
            id = "scaling"
            metric_stat {
              metric {
                metric_name = "CPUUtilization"
                namespace   = "AWS/EC2"
                dimensions {
                  name  = "AutoScalingGroupName"
                  value = aws_autoscaling_group.home-autoscale-grp.name
                }
              }
              stat = "Average"
            }
          }
        }
      }
    }
  }

#laptop-policy

resource "aws_autoscaling_policy" "laptop-policy" {
    autoscaling_group_name = aws_autoscaling_group.laptop-autoscale-grp.name
    name                   = "${var.project}-laptop-policy"
    policy_type            = "PredictiveScaling"
    predictive_scaling_configuration {
      metric_specification {
        target_value = 60
        predefined_load_metric_specification {
          predefined_metric_type = "ASGTotalCPUUtilization"
          resource_label         = "app/cloudblitz-lb/778d41231b141a0f/targetgroup/cloudblitz-tg-mobile/943f017f100becff"
        }
        customized_scaling_metric_specification {
          metric_data_queries {
            id = "scaling"
            metric_stat {
              metric {
                metric_name = "CPUUtilization"
                namespace   = "AWS/EC2"
                dimensions {
                  name  = "AutoScalingGroupName"
                  value = aws_autoscaling_group.laptop-autoscale-grp.name
                }
              }
              stat = "Average"
            }
          }
        }
      }
    }
  }

#mobile-policy

resource "aws_autoscaling_policy" "mobile-policy" {
    autoscaling_group_name = aws_autoscaling_group.mobile-autoscale-grp.name
    name                   = "${var.project}-mobile-policy"
    policy_type            = "PredictiveScaling"
    predictive_scaling_configuration {
      metric_specification {
        target_value = 60
        predefined_load_metric_specification {
          predefined_metric_type = "ASGTotalCPUUtilization"
          #resource_label         = "app/cloudblitz-lb/778d41231b141a0f/targetgroup/cloudblitz-tg-mobile/943f017f100becff"
        }
        customized_scaling_metric_specification {
          metric_data_queries {
            id = "scaling"
            metric_stat {
              metric {
                metric_name = "CPUUtilization"
                namespace   = "AWS/EC2"
                dimensions {
                  name  = "AutoScalingGroupName"
                  value = aws_autoscaling_group.mobile-autoscale-grp.name
                }
              }
              stat = "Average"
            }
          }
        }
      }
    }
  }
  


