variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  type        = string
}

variable "CLUSTER_NAME" {
  description = "AWS Cluster Name"
  type        = string
}
