output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_neptune_cluster.default.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_neptune_cluster.default.reader_endpoint
}

output "cluster_id" {
  description = "The cluster ID"
  value       = aws_neptune_cluster.default.id
}
