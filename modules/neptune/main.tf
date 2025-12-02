resource "aws_neptune_subnet_group" "default" {
  name       = "${var.project_name}-neptune-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-neptune-subnet-group"
  }
}

resource "aws_security_group" "neptune" {
  name        = "${var.project_name}-neptune-sg"
  description = "Security group for Neptune cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8182
    to_port     = 8182
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Open to world for demo purposes. Restrict in production.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-neptune-sg"
  }
}

resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = var.cluster_identifier
  engine                              = "neptune"
  skip_final_snapshot                 = var.skip_final_snapshot
  apply_immediately                   = var.apply_immediately
  neptune_subnet_group_name           = aws_neptune_subnet_group.default.name
  vpc_security_group_ids              = [aws_security_group.neptune.id]
  iam_database_authentication_enabled = false
}

resource "aws_neptune_cluster_instance" "default" {
  count              = 1
  cluster_identifier = aws_neptune_cluster.default.id
  engine             = "neptune"
  instance_class     = var.instance_class
  apply_immediately  = var.apply_immediately
}
