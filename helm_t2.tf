resource "helm_release" "prometheus" {
  name             = "prometheus-release"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 1200  # Increased to 20 minutes

  set {
    name  = "server.persistentVolume.enabled"
    value = "false"
  }

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.resources.limits.cpu"
    value = "250m"  # Reduced CPU limit
  }

  set {
    name  = "server.resources.limits.memory"
    value = "256Mi"  # Reduced memory limit
  }
  
  # Add minimal resource requests
  set {
    name  = "server.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "server.resources.requests.memory"
    value = "128Mi"
  }
  
  # Disable alertmanager to reduce resource usage
  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
}

resource "helm_release" "grafana" {
  name             = "grafana-release"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 1200  # Increased to 20 minutes
  depends_on = [helm_release.prometheus]

  set {
    name  = "persistence.enabled"
    value = "false"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "adminPassword"
    value = "admin"
  }

  set {
    name  = "resources.limits.cpu"
    value = "250m"  # Reduced CPU limit
  }

  set {
    name  = "resources.limits.memory"
    value = "256Mi"  # Reduced memory limit
  }
  
  # Add minimal resource requests
  set {
    name  = "resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "resources.requests.memory"
    value = "128Mi"
  }
}