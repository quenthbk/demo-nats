locals {
  event_source_name = "webhook"
}

resource "kubernetes_manifest" "cnpg_cluster" {
  for_each = toset(["test"])

  manifest = yamldecode(templatefile("${path.module}/manifests/cnpg/Cluster.yaml.tftpl", {
    NAME               = each.key
    NAMESPACE          = "default"
    INSTANCES          = 2
    STORAGE_SIZE       = "1Gi"
    MONITORING_ENABLED = true
  }))
}
