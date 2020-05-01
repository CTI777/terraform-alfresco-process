#!/usr/bin/env bash

cd $PWD/examples/rancher-eks/
export KUBECONFIG=/home/travis/build/Alfresco/terraform-alfresco-process/examples/rancher-eks/.terraform/kubeconfig
export K8S_API_URL=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$TF_VAR_cluster_name\")].cluster.server}")
terraform init
#remove acs namespace from state file
terraform state rm module.alfresco-content-services.kubernetes_namespace.acs
terraform refresh
terraform destroy --force