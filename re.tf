resource "aws_launch_configuration" "temp-home" {
    name = "${var.project}-temp-home"
    iamge_id = var.iamge_id
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = var.security_groups
    
}