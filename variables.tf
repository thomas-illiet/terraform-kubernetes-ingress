variable "name" {
  type        = string
  description = "Specific name for the ingress. Defaults to service name if not provided."
}

variable "namespace" {
  type        = string
  description = "Namespace where the service is located."
}

variable "annotations" {
  type        = map(string)
  description = "Custom annotations for the ingress."
  default     = {}
}

variable "class_name" {
  type        = string
  description = "Ingress class name to use. Typically 'nginx' or 'internal-nginx'."
  default     = "internal-nginx"
}

variable "domain" {
  type        = string
  description = "Global domain name for the ingress URLs (e.g., 'example.com')."
  default     = "example.com"
}

variable "paths" {
  description = <<-EOT
    List of paths to configure the ingress rules. Each object defines:
    - 'path': The URL path (e.g., '/api'). Defaults to '/'.
    - 'path_type': Type of the path (e.g., 'Prefix'). Defaults to 'ImplementationSpecific'.
    - 'service': The service name to route to.
    - 'port': The service port to target for the request.
  EOT
  type = list(object({
    path      = optional(string, "/")
    path_type = optional(string, "ImplementationSpecific")
    service   = string
    port      = number
  }))
}

variable "tls" {
  type        = string
  description = <<-EOT
    Optional secret name for TLS/SSL.
    If not provided, a default will be generated based on domain_name.
  EOT
  default     = null
}

variable "cluster_issuer" {
  type        = string
  description = "Cert-manager cluster issuer for managing TLS certificates."
  default     = "letsencrypt-prod"
}