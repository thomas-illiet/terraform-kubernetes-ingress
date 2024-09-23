# Complete

Below is a complete example that demonstrates how to use the module with all possible parameters.

```
module "kubernetes_ingress" {
  source = "thomas-illiet/ingress/kubernetes"
  version = "1.2.0"

  name           = "my-ingress"
  namespace      = "my-namespace"
  domain         = "example.com"
  class_name     = "nginx"
  cluster_issuer = "letsencrypt-prod"
  
  paths = [
    {
      path    = "/app"
      service = "app-service"
      port    = 80
    },
    {
      path    = "/api"
      service = "api-service"
      port    = 8080
    }
  ]

  tls = "my-custom-tls-secret"
  annotations = {
    "custom-annotation" = "value"
  }
}
```