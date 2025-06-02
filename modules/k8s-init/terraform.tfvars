helm_versions = {
  nats        = "1.3.7"
  argo_events = "2.4.15"
}

kubernetes_default_provider = {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
