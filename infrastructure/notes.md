### Get the storage access key and store it as an environment variable
```
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY
```

### Saving kube config
```
terraform output -raw kube_config > ~/.kube/config
```

### Export kube config path
```
export KUBE_CONFIG_PATH="~/.kube/config"
```

### Port forward argocd server service
```
kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:443
```

### Get argocd admin password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```