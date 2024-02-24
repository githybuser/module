provider "aws" {
    region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "network/terraform.tfstate"
    region = "us-east-2"
    }
}

resource "aws_instance" "my_instance" {
    ami = "ami-02ca28e7c7b8f8be1"
    instance_type = "t2.micro"
    key_name = "my-ohio-key"
    vpc_security_group_ids = [data.aws_security_group.my_sg.id]
}

data "aws_security_group" "my_sg" {
    vpc_id = "vpc-0bdeff502932dbc57"
    name = "http-allow"
    id = "sg-0ea5e5a448dcab1d7"
}

resource "aws_security_group_rule" "all-tcp" {
    from_port = 443
    to_port = 443
    type = "ingress"
    security_group_id = aws_security_group.my_sg.id
    cidr_blocks = ["0.0.0.0/0"]

}

output "my_instance_private_ip"
    value = aws_instance.my_instance.private_ip
