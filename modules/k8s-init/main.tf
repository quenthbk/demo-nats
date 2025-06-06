

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

# To refacto (for_each)
resource "kubernetes_namespace_v1" "cnpg" {
  metadata {
    name = "cnpg"
  }
}

# To refacto (for_each)
resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = "mon"
  }
}

locals {
  argo_ns = kubernetes_namespace_v1.argo.metadata[0].name
  cnpg_ns = kubernetes_namespace_v1.cnpg.metadata[0].name
  mon_ns  = kubernetes_namespace_v1.monitoring.metadata[0].name
}

resource "helm_release" "argo_events" {
  count = var.helm_versions.argo_events == null ? 0 : 1

  name       = "argo-events"
  namespace  = local.argo_ns
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-events"
  version    = var.helm_versions.argo_events # adapte à la dernière version stable

  create_namespace = false

  values = [
    file("${path.module}/helm/argo-events.yaml")
  ]
}

resource "helm_release" "cnpg" {
  count = var.helm_versions.argo_events == null ? 0 : 1

  name       = "cnpg"
  namespace  = local.cnpg_ns
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  version    = var.helm_versions.cnpg # adapte à la dernière version stable

  create_namespace = false
}

resource "helm_release" "prometheus" {
  count = var.helm_versions.prometheus == null ? 0 : 1

  name       = "prometheus"
  namespace  = local.mon_ns
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.helm_versions.prometheus # adapte à la dernière version stable

  create_namespace = false

  values = [
    file("${path.module}/helm/kube-prometheus-stack.yaml")
  ]
}
