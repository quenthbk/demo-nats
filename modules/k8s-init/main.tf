

###############
# Deploy NATS #
###############
resource "helm_release" "nats" {
  count = var.helm_versions.nats == null ? 0 : 1

  repository       = "https://nats-io.github.io/k8s/helm/charts/"
  chart            = "nats"
  name             = "nats"
  namespace        = "nats"
  create_namespace = true
  version          = var.helm_versions.nats
}


######################
# Deploy Argo Events #
######################
resource "kubernetes_namespace_v1" "argo" {
  metadata {
    name = "argo"
  }
}

locals {
  argo_ns = kubernetes_namespace_v1.argo.metadata[0].name
}

resource "helm_release" "argo_events" {
  count = var.helm_versions.argo_events == null ? 0 : 1

  name       = "argo-events"
  namespace  = local.argo_ns
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-events"
  version    = var.helm_versions.argo_events # adapte à la dernière version stable

  create_namespace = true

  values = [
    file("${path.module}/helm/argo-events.yaml")
  ]
}
