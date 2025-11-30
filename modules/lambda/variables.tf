variable "function_name" {
  type        = string
  description = "Name of the lambda function"
}

variable "runtime" {
  type        = string
  description = "Runtime for the lambda function"
  validation {
    condition     = contains(["python3.11", "python3.12", "java17", "java21", "java25"], var.runtime)
    error_message = "Runtime must be one of: python3.11, python3.12, java17, java21, java25"
  }
}

variable "env_variables" {
  type        = map(string)
  description = "Environment variables for the lambda function"
  default     = {}
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

variable "filename" {
  type        = string
  description = "Filename for the lambda function"
}

