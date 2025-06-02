variable "kubernetes_default_provider" {
  type = object({
    config_path    = string
    config_context = string
  })
}

provider "helm" {
  kubernetes {
    config_context = var.kubernetes_default_provider.config_context
    config_path    = var.kubernetes_default_provider.config_path
  }
}

provider "kubernetes" {
  config_context = var.kubernetes_default_provider.config_context
  config_path    = var.kubernetes_default_provider.config_path
}
