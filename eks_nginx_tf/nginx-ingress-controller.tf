resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
   depends_on = [
    module.eks
  ]

  set = [{
    name  = "Service.type"
    value = "LoadBalancer"
  }]
}

