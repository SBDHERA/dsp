variable "environment_name" {
  type        = string
  description = "The name of the target environment"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "replica_count" {
  type        = number
  description = "Number of server replicas for this environment"
}
