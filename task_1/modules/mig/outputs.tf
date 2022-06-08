
output "mig_self_link" {
  description = "Self-link for managed instance group"
  value       = module.ig.self_link
}

output "health_self_link" {
  description = "Self-link for managed instance group"
  value       = module.ig.health_check_self_links
}

output "instance_group" {
  description = "Instance group ID"
  value       = module.ig.instance_group
}