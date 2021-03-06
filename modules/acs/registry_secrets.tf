resource "kubernetes_namespace" "acs" {
  metadata {
    name = "acs"
  }
}

locals {
  quaydockercfg = {
    "auths" = {
      "${var.quay_url}" = {
        username   = var.quay_user
        password   = var.quay_password
        email      = "none"
        auth_token = base64encode("${var.quay_user}:${var.quay_password}")
      }
    }
  }
}

resource "kubernetes_secret" "quay-registry-secret" {
  metadata {
    name      = "quay-registry-secret"
    namespace = var.namespace
  }

  data = map(
    ".dockerconfigjson", jsonencode(local.quaydockercfg)
  )

  type = "kubernetes.io/dockerconfigjson"

  depends_on = [kubernetes_namespace.acs]
}
