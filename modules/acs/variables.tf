variable "cluster_url" {
  default     = ""
  description = "cluster url"
}

variable "cluster_host" {
  default     = ""
  description = "cluster host"
}

variable "cluster_domain" {
  default     = ""
  description = "cluster domain"
}

variable "acs_enabled" {
  default     = true
  description = "install Alfresco Content Services as part of the Alfresco Process Infrastructure"
}

variable "registry_user" {
  default     = "registry"
  description = "username for the deployment docker registry"
}

variable "registry_password" {
  default     = "password"
  description = "password for the deployment docker registry"
}

variable "aws_efs_dns_name" {
  default     = ""
  description = "EFS DNS name to be used for ACS file storage (optional AWS only)"
}

variable "kubernetes_token" {
  description = "Kubernetes API token"
  default     = ""
}

variable "kubernetes_api_server" {
  description = "Kubernetes API server URL"
  default     = "https://kubernetes"
}

variable "quay_user" {
  description = "quay user name"
}

variable "quay_password" {
  description = "quay user password"
}

variable "quay_url" {
  description = "quay url in docker registry format, defaults to \"quay.io\""
  default     = "quay.io"
}

variable "helm_service_account" {
  default     = "tiller"
  description = "service account used by helm"
}

variable "identity_host" {
  default     = ""
  description = "identity host"
}