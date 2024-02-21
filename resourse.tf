provider "aws"{
  region = "us-east-2"
}
resource "aws_eks_cluster" "practice-cluster" {
    name = "${var.project}-cluster"
    role_arn = var.role_arn 
    access_config {
        authentication_mode = "API_AND_CONFIG_MAP"  
        bootstrap_cluster_creator_admin_permissions = true  
    }
    vpc_config {
        subnet_ids = var.subnet_ids 
        endpoint_private_access = true
        endpoint_public_access = true
    }

}