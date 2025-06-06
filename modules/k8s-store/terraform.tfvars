#
# Can be refacto with terragrunt
#
kubernetes_default_provider = {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
