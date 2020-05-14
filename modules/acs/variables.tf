variable "namespace" {
  default     = "acs"
  description = "kubernetes namespace to install to"
}

variable "acs_enabled" {
  default     = true
  description = "install Alfresco Content Services"
}

variable "cluster_host" {
  description = "cluster host"
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
  description = "identity host"
}
