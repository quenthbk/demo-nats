locals {
  event_source_name = "webhook"
}

# @TODO - Add Storage Class
resource "kubectl_manifest" "event_bus" {
  yaml_body = templatefile(
      "${path.module}/manifests/EventBus.yaml.tftpl", {
        NAME      = "default"
        NAMESPACE = var.namespace
      }
    )
}

resource "kubectl_manifest" "event_source_webhook" {
  yaml_body = templatefile("${path.module}/manifests/EventSourceWebhook.yaml.tftpl", {
    NAME         = local.event_source_name
    NAMESPACE    = var.namespace
    SERVICE_PORT = 12000
    ENDPOINT     = "/trigger"
  })
}

resource "kubectl_manifest" "sensor" {
  yaml_body = templatefile(
      "${path.module}/manifests/Sensor.yaml.tftpl", {
        NAME                = "default"
        NAMESPACE           = var.namespace
        SERVICE_ACCOUNT     = local.sensor_sa
        WEBHOOK_SOURCE_NAME = local.event_source_name
      }
    )
}
