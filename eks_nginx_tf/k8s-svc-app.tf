resource "kubernetes_service_v1" "app1_svc" {
  metadata {
    name = "app1-svc"
  }

 depends_on = [
    module.eks
  ]
  spec {
    selector = {
      app = kubernetes_pod_v1.app1.metadata.labels.app
    }
    port {
      port = 5678
    }
  }
}

resource "kubernetes_service_v1" "app2_svc" {
  metadata {
    name = "app2-svc"
  }

 depends_on = [
    module.eks
  ]

  spec {
    selector = {
      app = kubernetes_pod_v1.app2.metadata.labels.app
    }
    port {
      port = 5678
    }
  }
}


