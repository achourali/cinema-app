### Steps
- Running the script infrastructure/backendstate.sh 
```
source infrastructure/backendstate.sh
```
- Infrastructure provisioning with terraform. AKS provisiong + installing argocd + applying argocd application 
```
cd ./infrastructure;terraform init; terraform apply 
```
- Saving kube config
```
terraform output -raw kube_config > ~/.kube/config
```
- Export kube config path
```
export KUBE_CONFIG_PATH="~/.kube/config"
```
- Applying secrets.yaml
```
kubectl apply -f secrets.yaml
```
- Port forward argocd server 
```
kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:443
```
- You can get the argocd admin password with this command
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
``` 
- In argocd you will find an application for the cinema app ( applied previously with terraform), you can sync manually this application.
- Argocd is watching the helm charts in ./charts/cinema
- You can obtain the website public ip with this command 
```
kubectl get svc cinema-website -o jsonpath="{.status.loadBalancer.ingress[0].ip}"
```
- To build and push docker images of the microservices add a "v*" tag 
