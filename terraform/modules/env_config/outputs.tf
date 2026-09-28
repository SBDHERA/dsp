output "file_path" {
  value       = local_file.env_config.filename
  description = "The absolute path of the generated environment file"
}
