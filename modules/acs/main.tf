data "helm_repository" "alfresco" {
  name = "alfresco"
  url  = "https://kubernetes-charts.alfresco.com/stable"
}

resource "helm_release" "alfresco-content-services" {
  count      = var.acs_enabled ? 1 : 0
  name       = "acs"
  repository = data.helm_repository.alfresco.url
  chart      = "alfresco-content-services"
  version    = "3.0.8"
  namespace  = var.namespace

  values = [
    <<EOF
global:
  alfrescoRegistryPullSecrets: quay-registry-secret
repository:
  image:
    tag: 6.3.0-EVENTS-1
  replicaCount: 1
  ingress:
    hostName: ${var.cluster_host}
    path: /alfresco
    maxUploadSize: "500m"
  readinessProbe:
    initialDelaySeconds: 140
  environment:
    IDENTITY_SERVICE_URI: "https://${var.identity_host}/auth"
    IDENTITY_SERVICE_REALM: "alfresco"
    IDENTITY_SERVICE_RESOURCE: "activiti"
    JAVA_OPTS: "
      -Dsolr.base.url=/solr
      -Dsolr.secureComms=none
      -Dindex.subsystem.name=solr6
      -Dalfresco.cluster.enabled=true
      -Ddeployment.method=HELM_CHART
      -Xms1800M -Xmx1800M
      -Dauthentication.chain=identity-service1:identity-service,alfrescoNtlm1:alfrescoNtlm
      -Didentity-service.enable-basic-auth=true
      -Didentity-service.authentication.validation.failure.silent=false
      -Didentity-service.auth-server-url=\"$IDENTITY_SERVICE_URI\"
      -Didentity-service.realm=\"$IDENTITY_SERVICE_REALM\"
      -Didentity-service.resource=\"$IDENTITY_SERVICE_RESOURCE\"
      -Dlocal.transform.service.enabled=false
      -Dtransform.service.enabled=false
      "
share:
  replicaCount: 1
  ingress:
    hostName: ${var.cluster_host}
imagemagick:
  replicaCount: 1
libreoffice:
  replicaCount: 1
pdfrenderer:
  replicaCount: 1
tika:
  replicaCount: 1
transformrouter:
  replicaCount: 1
transformmisc:
  replicaCount: 1
alfresco-digital-workspace:
  enabled: false
postgresql:
  imageTag: 11.3
  persistence:
    existingClaim: null
alfresco-sync-service:
  enabled: false
externalHost: ${var.cluster_host}
externalProtocol: https
externalPort: 443
alfresco-infrastructure:
  alfresco-infrastructure:
    alfresco-identity-service:
      enabled: false
    nginx-ingress:
      enabled: false
  persistence:
    enabled: true
    baseSize: 2Gi
    storageClass:
      enabled: true
      accessModes:
        - ReadWriteMany
      name: default-sc
EOF
  ]

  timeout = 900
  //set timeout to 15m

  depends_on = [
    kubernetes_secret.quay-registry-secret
  ]
}
