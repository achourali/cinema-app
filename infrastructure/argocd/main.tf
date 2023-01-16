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
