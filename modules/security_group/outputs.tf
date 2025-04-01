output "security_group_id" {
  description = "ID of the created security group"
  value       = yandex_vpc_security_group.example.id
}

output "security_group_name" {
  description = "Name of the created security group"
  value       = yandex_vpc_security_group.example.name
}