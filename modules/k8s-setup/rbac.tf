####################
# Service Accounts #
####################
resource "kubernetes_service_account_v1" "sensor" {
  metadata {
    name      = "sensor-sa"
    namespace = var.namespace
  }
}

#########
# Roles #
#########
resource "kubernetes_role_v1" "job_creator" {
  metadata {
    name = "job-creator"
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["create", "get", "list", "watch"]
  }
}

locals {
  sensor_sa        = kubernetes_service_account_v1.sensor.metadata[0].name
  job_creator_role = kubernetes_role_v1.job_creator.metadata[0].name
}


############
# Bindings #
############
resource "kubernetes_role_binding_v1" "sensor" {
  metadata {
    name = "bind-sensor-job-creator"
    namespace = var.namespace
  }

  subject {
    kind      = "ServiceAccount"
    name      = local.sensor_sa
    namespace = var.namespace
  }

  role_ref {
    kind      = "Role"
    api_group = "rbac.authorization.k8s.io"
    name      = local.job_creator_role
  }
}
