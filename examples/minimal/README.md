# Minimal

Below is a simple configuration that showcases the essential parameters required to set up the Ingress resource.

```
module "kubernetes_ingress" {
  source = "thomas-illiet/ingress/kubernetes"
  version = "1.2.2"

  name      = "test"
  domain    = "example.com"
  namespace = "demo"
  paths = [
    {
      service = "nginx"
      port    = "8080"
    }
  ]
}
```