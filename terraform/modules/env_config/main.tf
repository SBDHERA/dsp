
resource "local_file" "env_config" {
  filename = "${path.module}/config-${var.environment_name}.json"
  content  = jsonencode({
    project         = var.project_name
    environment     = var.environment_name
    server_replicas = var.replica_count
    status          = "active"
    managed_by      = "Terraform Module"
    updated_at      = timestamp()
  })
}