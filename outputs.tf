output "id" {
  value = "${null_resource.kontena_service.id}-${null_resource.kontena_service_update.id}"
}
