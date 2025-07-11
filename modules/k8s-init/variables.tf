
variable "helm_versions" {
  type = object({
    nats        = optional(string, null)
    argo_events = optional(string, null)
    cnpg        = optional(string, null)
    prometheus  = optional(string, null)
  })
}
