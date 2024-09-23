module "kubernetes_ingress" {
  source  = "thomas-illiet/ingress/kubernetes"
  version = "1.0.4"

  ingress_name       = "my-ingress"
  service_namespace  = "my-namespace"
  domain_name        = "example.com"
  ingress_class_name = "nginx"
  cluster_issuer     = "letsencrypt-prod"

  paths = [
    {
      path          = "/app"
      service_name  = "app-service"
      external_port = 80
    },
    {
      path          = "/api"
      service_name  = "api-service"
      external_port = 8080
    }
  ]

  tls = "my-custom-tls-secret"
  annotations = {
    "custom-annotation" = "value"
  }
}