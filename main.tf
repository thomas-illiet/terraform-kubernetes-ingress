resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name      = var.name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      {
        "cert-manager.io/cluster-issuer" = var.cluster_issuer
        "terraform.io/module.source"     = local.source
        "terraform.io/module.version"    = local.version
      }
    )
  }
  spec {
    ingress_class_name = var.class_name
    rule {
      host = var.domain
      http {
        dynamic "path" {
          for_each = var.paths
          content {
            path      = path.value.path
            path_type = path.value.path_type
            backend {
              service {
                name = path.value.service
                port {
                  number = path.value.port
                }
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = var.tls != null ? var.tls : "${replace(var.domain, ".", "-")}-tls"
      hosts       = [var.domain]
    }
  }
}
