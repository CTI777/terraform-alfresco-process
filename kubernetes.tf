resource "kubernetes_secret" "aae-license" {
  metadata {
    name = "licenseaps"
  }

  data = {
    "activiti.lic" = file(var.aae_license)
  }
}

