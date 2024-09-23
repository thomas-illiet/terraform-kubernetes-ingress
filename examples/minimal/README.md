# Minimal

Below is a simple configuration that showcases the essential parameters required to set up the Ingress resource.

```
module "kubernetes_ingress" {
  source = "thomas-illiet/ingress/kubernetes"
  version = "1.1.0"

  ingress_name      = "test"
  domain_name       = "example.com"
  service_namespace = "demo"
  paths = [
    {
      service_name  = "nginx"
      external_port = "8080"
    }
  ]
}
```