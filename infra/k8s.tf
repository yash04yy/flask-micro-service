resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_secret" "app_secret" {
  metadata {
    name      = "flask-secret"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    API_KEY = base64encode("mysecretapikey123")
  }

  type = "Opaque"
}

resource "kubernetes_deployment" "flask_app" {
  metadata {
    name      = "flask-app"
    namespace = kubernetes_namespace.dev.metadata[0].name
    labels = {
      app = "flask"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "flask"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask"
        }
      }

      spec {
        container {
          name = "flask-container"
          # IMPORTANT: replace YOUR_GITHUB_USERNAME with the real owner/org
          image = "ghcr.io/yash04yy/flask-micro-service/flask-micro-service:latest"
          port {
            container_port = 5000
          }
          # If you need env from secret uncomment below block and adapt
          # env_from {
          #   secret_ref {
          #     name = kubernetes_secret.app_secret.metadata[0].name
          #   }
          # }
        }
      }
    }
  }
}
