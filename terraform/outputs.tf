output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  value       = var.AWS_ACCESS_KEY_ID
}

output "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  value       = var.AWS_SECRET_ACCESS_KEY
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}
