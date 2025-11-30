variable "function_name" {
  type        = string
  description = "Name of the lambda function"
}

variable "role" {
  type        = string
  description = "Role ARN for the lambda function"
}

variable "region" {
  type        = string
  description = "Region for the lambda function"
}

variable "env" {
  type        = map(string)
  description = "Environment for the lambda function"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags for the lambda function"
  default     = {}
}
