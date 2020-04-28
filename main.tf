data "helm_repository" "alfresco-incubator" {
  name = "alfresco-incubator"
  url  = "https://kubernetes-charts.alfresco.com/incubator"
}

data "helm_repository" "alfresco" {
  name = "alfresco"
  url  = "https://kubernetes-charts.alfresco.com/stable"
}

resource "helm_release" "alfresco-process-infrastructure" {
  name       = "aae"
  repository = data.helm_repository.alfresco-incubator.url
  chart      = "alfresco-process-infrastructure"
  version    = "7.1.0-M7"

  values = [
    <<EOF
global:
  registryPullSecrets:
    - quay-registry-secret
  gateway:
    http: false
    host: "${var.gateway_host}"
    domain: "${local.cluster_domain}"
  keycloak:
    realm: alfresco
    host: "${local.identity_host}"
alfresco-deployment-service:
  alfresco-content-services:
    enabled: ${var.acs_enabled ? true : false}
  dockerRegistry:
    server: "${var.registry_host}"
    password: "${var.registry_password}"
    userName: "${var.registry_user}"
    secretName: "aae-registry-secret"
  environment:
    apiUrl: "${var.kubernetes_api_server}"
    apiToken: "${var.kubernetes_token}"
  connectorVolume:
    storageClass: ${var.aws_efs_dns_name != "" ? "default-sc" : ""}
    permission: ${var.aws_efs_dns_name != "" ? "ReadWriteMany" : ""}
nfs-server-provisioner:
  enabled: ${var.aws_efs_dns_name == ""}
persistence:
  enabled: true
EOF
    ,
  ]
  timeout    = 600 //set timeout to 10m 
  depends_on = [kubernetes_secret.quay-registry-secret]
}

