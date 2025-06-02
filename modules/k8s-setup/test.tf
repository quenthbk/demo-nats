resource "kubernetes_pod" "curl_client" {
  metadata {
    name      = "curl-client"
    namespace = var.namespace
    labels = {
      app = "curl-client"
    }
  }

  spec {
    container {
      name  = "curl"
      image = "curlimages/curl:latest"
      command = ["sleep", "infinity"]
      tty     = true
    }

    restart_policy = "Never"
  }
}
