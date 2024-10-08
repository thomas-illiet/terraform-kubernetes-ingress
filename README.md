# Kubernetes Ingress with Terraform

This Terraform module manages Kubernetes Ingress resources using the Kubernetes provider. It allows you to configure Ingress rules, TLS certificates, and service paths dynamically based on inputs, providing flexibility for different environments.

## Repository

This project is automatically mirrored on GitHub for sharing via the Terraform registry. For any issues or contributions, please use the original GitLab repository.

- **Original (GitLab):** <https://gitlab.com/netified/terraform/kubernetes-ingress>
- **Mirror (GitHub):** <https://github.com/thomas-illiet/terraform-kubernetes-ingress>
- **Registry:** <https://registry.terraform.io/modules/thomas-illiet/ingress/kubernetes/latest>

## Features

* **Ingress Rules**: Easily define paths, backends, and ingress rules.
* **TLS Configuration**: Optional TLS support using cert-manager.
* **Ingress Class**: Specify the ingress class for the resource (e.g., NGINX, internal-nginx).
* **Dynamic Annotations**: Add custom annotations and handle defaults for Cert-Manager integration.

## Usage

Full configuration:

```hcl
module "kubernetes_ingress" {
  source = "thomas-illiet/ingress/kubernetes"
  version = "1.2.2"

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

Minimal configuration:

```hcl
module "kubernetes_ingress" {
  source = "thomas-illiet/ingress/kubernetes"
  version = "1.2.0"

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

## Variables

| Name             | Type     | Default              | Description                                                                                                    |
| ---------------- | -------- | -------------------- | -------------------------------------------------------------------------------------------------------------- |
| `name`           | `string` | `null`               | Name for the Ingress resource. Defaults to the namespace name if not provided.                                 |
| `namespace`      | `string` | -                    | Namespace where the service is located.                                                                        |
| `annotations`    | `map`    | `{}`                 | Custom annotations for the ingress. Merges with default annotations for cert-manager.                          |
| `class_name`     | `string` | `"internal-nginx"`   | The class name for the ingress controller. Typically `nginx` or `internal-nginx`.                              |
| `domain`         | `string` | `"example.com"`      | Global domain name for all ingress URLs.                                                                       |
| `paths`          | `list`   | -                    | A list of paths defining the service routing and backend service configuration.                                |
| `tls`            | `string` | `null`               | Name of the TLS secret for HTTPS termination. If not provided, a secret is generated based on the domain name. |
| `cluster_issuer` | `string` | `"letsencrypt-prod"` | Cert-manager cluster issuer name to handle TLS certificates.                                                   |


### Paths Object

The `paths` variable is a list of objects, each defining an ingress rule for a specific path.

| Name        | Type     | Description                                                                       |
| ----------- | -------- | --------------------------------------------------------------------------------- |
| `path`      | `string` | URL path to route (e.g., `/app`, defaults to `ImplementationSpecific`).           |
| `path_type` | `string` | Type of the path (e.g., `Prefix`, `Exact`, defaults to `ImplementationSpecific`). |
| `service`   | `string` | Kubernetes service name to forward the traffic to.                                |
| `port`      | `number` | External port for the service (e.g., `80`, `8080`).                               |

## License

This module is licensed under the MIT License.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.