output "id" {
  value = kubernetes_ingress_v1.ingress.id
}

output "urls" {
  value = kubernetes_ingress_v1.ingress.spec[*].rule[*].host
}