resource "helm_release" "prometheus_stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "47.6.1"

  namespace        = "prometheus-stack"
  create_namespace = true

  values = [
    "${file("values/prometheus.yaml")}"
  ]

  depends_on = [
    kind_cluster.default
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.58.4"

  namespace        = "grafana"
  create_namespace = true

  values = [
    "${file("values/grafana.yaml")}"
  ]

  depends_on = [
    kind_cluster.default
  ]

}

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "5.23.0"

  namespace        = "loki"
  create_namespace = true

  values = [
    "${file("values/loki.yaml")}"
  ]

  depends_on = [
    kind_cluster.default
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.11.9"

  namespace = "loki"

  values = [
    "${file("values/promtail.yaml")}"
  ]

  depends_on = [
    kind_cluster.default
  ]
}
