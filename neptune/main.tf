data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "neptune" {
  source              = "../modules/neptune"
  project_name        = "shopping-graph"
  cluster_identifier  = "shopping-graph-cluster"
  instance_class      = "db.t4g.medium"
  vpc_id              = data.aws_vpc.default.id
  subnet_ids          = data.aws_subnets.default.ids
  skip_final_snapshot = true
}

output "neptune_endpoint" {
  value = module.neptune.cluster_endpoint
}
