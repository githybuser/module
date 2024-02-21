provider "aws"{
  region = "us-east-2"
}
resource "aws_eks_cluster" "practice-cluster" {
    name = "${var.project}-cluster"
    role_arn = var.role_arn 
    vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    }
    access_config {
        authentication_mode = "API_AND_CONFIG_MAP"  
        bootstrap_cluster_creator_permission = true  
    }
    
    vpc_config {
        security_group_ids = var.security_group_ids
        subnet_ids = var.subnet_ids 
        endpoint_private_access = true
        endpoint_public_access = true
    }

}