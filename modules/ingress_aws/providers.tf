provider "helm" {
  version         = "~> 0.10"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.14.3"
  service_account = var.helm_service_account
}

