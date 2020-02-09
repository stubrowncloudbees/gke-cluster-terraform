kubectl create namespace cloudbees-core
kubectl config set-context $(kubectl config current-context) --namespace=cloudbees-core
