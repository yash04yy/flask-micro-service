output "namespace" {
  description = "Kubernetes namespace created for the app"
  value       = kubernetes_namespace.dev.metadata[0].name
}

output "deployment_name" {
  description = "Name of the Kubernetes Deployment"
  value       = kubernetes_deployment.flask_app.metadata[0].name
}
