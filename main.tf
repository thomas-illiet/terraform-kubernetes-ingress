resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name      = var.ingress_name
    namespace = var.service_namespace
    annotations = merge(
      var.annotations,
      {
        "cert-manager.io/cluster-issuer" = var.cluster_issuer
        "terrafom.io/module.source"      = local.source
        "terrafom.io/module.version"     = local.version
      }
    )
  }
  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      http {
        dynamic "path" {
          for_each = var.paths
          content {
            path      = path.value.path
            path_type = path.value.path_type
            backend {
              service {
                name = path.value.service_name
                port {
                  number = path.value.external_port
                }
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = var.tls != null ? var.tls : "${replace(var.domain_name, ".", "-")}-tls"
      hosts       = [var.domain_name]
    }
  }
}
