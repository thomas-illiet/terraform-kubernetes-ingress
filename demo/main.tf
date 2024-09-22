module "url_jenkins" {
  source            = "../"
  ingress_name      = "test"
  domain_name       = "example.com"
  service_namespace = "demo"
  paths = [
    {
      service_name  = "nginx"
      external_port = "8080"
    },
    {
      path          = "/phpmyadmin"
      service_name  = "phpmyadmin"
      external_port = "9090"
    },
  ]
}
