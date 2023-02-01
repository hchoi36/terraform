module "eks" {
  source           = "terraform-aws-modules/eks/aws"
   version         = "17.24.0"
  cluster_name     = "CloudGuard-Kubernetes"
  cluster_version  = "1.19"
  subnets          = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = 2
    },
  ]
}

output "env-dynamic-url" {
  value = module.eks.cluster_endpoint
}
