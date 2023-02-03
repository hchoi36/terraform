provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, list("")), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, list("")), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, list("")), 0)
  load_config_file       = false
  version                = "1.9"
}

module "eks" {
  source           = "terraform-aws-modules/eks/aws"
   version         = "17.24.0"
  cluster_name     = "Antra-Kubernetes"
  cluster_version  = "1.19"
  subnets          = ["subnet-0f78a8893b01ab3b0","subnet-0e0112694839b9e7a"]
  vpc_id = "vpc-071c9a3420aa5120a"
  
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      #additional_userdata           = "echo foo bar"
      #additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = 1
      #enable_monitoring = false 
    },
  ]
}

output "env-dynamic-url" {
   value = module.eks.cluster_endpoint
}
