
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

provider "local" {}

# Define variables for multi-environment tracking
variable "environment" {
  type    = string
  default = "development"
}

# Generate an environment configuration status file
resource "local_file" "env_config" {
  filename = "${path.module}/config-${var.environment}.json"
  content  = jsonencode({
    project     = "dsp-ecommerce-infra"
    environment = var.environment
    status      = "active"
    managed_by  = "Terraform"
    updated_at  = timestamp()
  })
}

output "config_file_path" {
  value       = local_file.env_config.filename
  description = "The path to the generated environment configuration file."
}