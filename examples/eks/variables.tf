# settings for AWS Provider
variable "aws_region" {
  description = "AWS region"
}

variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret key"
}

# settings for your cluster
variable "project_name" {
  default     = null
  description = "project name"
}

variable "project_environment" {
  default     = null
  description = "project environment like dev/prod/staging"
}

variable "cluster_name" {
  default     = null
  description = "name for your cluster, if not set it will be a concatenation of project_name and project_environment"
}

# Quay Registry settings
variable "quay_url" {
  description = "quay url in docker registry format, defaults to \"quay.io\""
  default     = "quay.io"
}

variable "quay_user" {
  description = "quay user name"
}

variable "quay_password" {
  description = "quay user password"
}

variable "zone_domain" {
  description = "Zone domain"
}

# AAE/AAE settings
variable "aae_license" {
  description = "location of your AAE license file"
}

# APS/AAE Deployment Registry settings
variable "registry_host" {
  default     = ""
  description = "deployment docker registry"
}

variable "registry_user" {
  default     = "registry"
  description = "username for the deployment docker registry"
}

variable "registry_password" {
  default     = "password"
  description = "password for the deployment docker registry"
}

variable "gateway_host" {
  default     = ""
  description = "gateway host"
}

variable "identity_host" {
  default     = ""
  description = "identity host"
}

variable "kubernetes_token" {
  description = "Kubernetes API token"
  default     = ""
}

variable "kubernetes_api_server" {
  description = "Kubernetes API server URL"
  default     = "https://kubernetes"
}

# ACS settings
variable "acs_enabled" {
  default     = true
  description = "install Alfresco Content Services as part of the Alfresco Process Infrastructure"
}

variable "my_ip_address" {
  default     = "0.0.0.0/0"
  description = "CIDR blocks for ssh access to cluster nodes"
}

variable "node_groupname" {
  default     = "ng-1"
  description = "Group name for the worker nodes"
}
