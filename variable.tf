variable "role_arn" {
    default = "arn:aws:iam::851725416281:role/eks-role"
}

variable "project"{
    default = "trail-cluster"
 }

variable "subnet_ids" {
    default = ["subnet-09a5a22df3420ec81","subnet-080501de0b5a61f9f"]
}

variable "security_group_ids" {
    default = "sg-0bbab5807f28074db"
}

