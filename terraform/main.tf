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

# Define a list of target environments to manage infrastructure for
variable "environments" {
  type    = list(string)
  default = ["development", "staging", "production"]
}

# Use a local lookup map to set instance scales based on environment type
variable "instance_scales" {
  type = map(number)
  default = {
    development = 1
    staging     = 2
    production  = 5
  }
}

# Dynamically generate configuration files for each environment using `for_each`
resource "local_file" "env_configs" {
  for_each = toset(var.environments)

  filename = "${path.module}/config-${each.key}.json"
  content  = jsonencode({
    project        = "dsp-ecommerce-infra"
    environment    = each.key
    server_replicas = var.instance_scales[each.key]
    status         = "active"
    managed_by     = "Terraform"
    updated_at     = timestamp()
  })
}

# Output the paths of all generated environment configurations
output "generated_configs" {
  value       = { for env, file in local_file.env_configs : env => file.filename }
  description = "Paths to all generated multi-environment infrastructure config files."
}