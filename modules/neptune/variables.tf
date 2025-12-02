variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "cluster_identifier" {
  description = "The cluster identifier"
  type        = string
}

variable "instance_class" {
  description = "The instance class for Neptune cluster instances"
  type        = string
  default     = "db.t4g.medium"
}

variable "vpc_id" {
  description = "The VPC ID where Neptune will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Neptune subnet group"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}
