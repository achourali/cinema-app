resource "kubernetes_namespace" "kn" {
  metadata {
    name = "argocd"
  }
}


resource "helm_release" "argo" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.kn.id
}


resource "kubectl_manifest" "argocd_application" {
  depends_on = [helm_release.argo]
  yaml_body  = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cinema
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/achourali/cinema-app
    targetRevision: HEAD
    path: charts/cinema
    helm:
      valueFiles:
      - values.yaml
      - charts/bookings/values.yaml  
      - charts/showtimes/values.yaml 
      - charts/website/values.yaml 
      - charts/movies/values.yaml   
      - charts/users/values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: default

YAML

}
