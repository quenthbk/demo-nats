helm_versions = {
  nats        = "1.3.7"  # Build - 
  argo_events = "2.4.15" # Build - 
  cnpg        = "0.24.0" # Build - 2025-05-23
  prometheus  = "73.2.0" # Build - 2025-06-05
}

kubernetes_default_provider = {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
