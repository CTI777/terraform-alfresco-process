resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller-clusterrole-binding" {
  metadata {
    name = "tiller-clusterrole-binding"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }

  depends_on = [kubernetes_service_account.tiller]
}

resource "null_resource" "wait-for-tiller" {
  triggers = {
    always = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
counter=0
timeout=90
interval=2
tillerready=""
echo "Waiting for tiller"
while [ "$tillerready" = "" ] && [ "$counter" -le "$timeout" ]; do
  tillerready=$(kubectl get pods -n kube-system -o=custom-columns=NAME:.metadata.name,READY:.status.conditions[?\(@.type==\'Ready\'\)].status| grep tiller | grep True)
  sleep $interval
  printf .
  counter=$((counter + 1));
done
    EOF
  }
}
