#create cluster
k3d cluster create IoT

#create namespace
kubectl apply -f confs/namespaces.yaml

#check if namespaces are created
kubectl get namespaces

#Add Argo CD Helm repo
helm repo add argo https://argoproj.github.io/argo-helm

#update all package
helm repo update

#Install Argo CD via Helm
helm install argocd argo/argo-cd   --namespace argocd   --values confs/argocd/values.yaml   --create-namespace  

# check if all pods ARGOCD are there
kubectl get all -n argocd

#apply de definition of app ArgoCD
kubectl apply -f myapp-argocd.yaml

#Port-forward Argo CD server to access web UI
#kubectl port-forward svc/argocd-server -n argocd 8080:443
#kubectl port-forward svc/myapp -n dev 8888:8888 

#get pass for log in argo cd
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
