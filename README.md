# Install GKE CLuster

```
export ENVIRONMENT=production
terraform workspace new ${ENVIRONMENT}

export BUCKET_ID=...your ID goes here...
gsutil versioning set on gs://${BUCKET_ID}
Enabling versioning for gs://gke-from-scratch-terraform-state/...
gsutil versioning get gs://${BUCKET_ID}
gs://gke-from-scratch-terraform-state: Enabled


export PROJECT=gke-from-scratch
export SERVICE_ACCOUNT=terraform
gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com --role roles/editor

export ENVIRONMENT=production
terraform apply -var-file=${ENVIRONMENT}.tfvars
```


* Set kubeconfig

```
gcloud container clusters get-credentials stu-brown-ps-cluster --region us-east1

```

## Install Core and associated components 

* Running ```install_all.sh``` will run all subsequent scripts

* Install HELM
```
#install_helm.sh
* Install Helm
echo "install helm"
# installs helm with bash commands for easier command line integration
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
# add a service account within a namespace to segregate tiller
kubectl --namespace kube-system create sa tiller
# create a cluster role binding for tiller
kubectl create clusterrolebinding tiller \
    --clusterrole cluster-admin \
    --serviceaccount=kube-system:tiller

echo "initialize helm"
# initialized helm within the tiller service account
helm init --service-account tiller
# updates the repos for Helm repo integration
helm repo update

echo "verify helm"
# verify that helm is installed in the cluster
kubectl get deploy,svc tiller-deploy -n kube-system
```
* Install cluster admin role

```
#install_cluster_admin.sh
kubectl create clusterrolebinding cluster-admin-binding  --clusterrole cluster-admin  --user $(gcloud config get-value account)
```

* Install storage class

```
#create_ssd_storage.sh
echo "apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ssd
provisioner: kubernetes.io/gce-pd
# Allows volumes to be expanded after their creation.
allowVolumeExpansion: true
# Uncomment the following for multi zone clusters
# volumeBindingMode: WaitForFirstConsumer
parameters:
  type: pd-ssd" | kubectl create -f -
```

* Set default storage class
```
#make_ssd_default.sh
kubectl annotate storageclass standard storageclass.kubernetes.io/is-default-class-
kubectl annotate storageclass ssd storageclass.kubernetes.io/is-default-class=true

```

```
#create_ns.sh
kubectl create namespace cloudbees-core
kubectl config set-context $(kubectl config current-context) --namespace=cloudbees-core
```

* Install Ingress

```
#install_ingress_helm.sh
helm install --namespace ingress-nginx \
             --name nginx-ingress stable/nginx-ingress \
             --values values.yaml \
             --version 1.4.0
```



note: by default the instruction state use cloudbees-core namespace, changed to ingres-nginx

or 


```
#install_ingress_manual.sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/provider/cloud-generic.yaml
```
```
kubectl patch deployment.apps/nginx-ingress-controller -p '{"spec":{"template":{"spec":{"nodeSelector":{"kubernetes.io/os":null}}}}}' -n ingress-nginx
kubectl patch deployment.apps/nginx-ingress-controller -p '{"spec":{"template":{"spec":{"nodeSelector":{"beta.kubernetes.io/os":"linux"}}}}}' -n ingress-nginx
```

* patch ingress replicas 
```
#patch_replica_count.yaml
kubectl patch deployment.apps/nginx-ingress-controller -p '{"spec": {"replicas": 3}}' -n ingress-nginx
```

* Check/Create Certs and secret

```
#./create_certs.sh
mypwd=`pwd`
export DOMAIN_NAME=cloudbees.core.pscbdemos.com
cFILE=~/CA/${DOMAIN_NAME}/cert.pem
    echo "checking for ${cFILE}"
if [ ! -e "$cFILE" ]; then
    echo "cert does not exist so creating for ${DOMAIN_NAME}"
    if [ ! -e ./ca/minica ]; then
        echo "unzipping minica"
        unzip ./ca/minica.zip -d ca
    fi
    echo "creating cert and key for ${DOMAIN_NAME}"
    cd ~/CA/;$mypwd/ca/minica -domains ${DOMAIN_NAME}
    cd $mypwd
fi

echo "creating secret for ${DOMAIN_NAME}"
kubectl create secret tls cloudbees-core-tls --key ~/CA/${DOMAIN_NAME}/key.pem --cert ~/CA/${DOMAIN_NAME}/cert.pem --namespace cloudbees-core

```

* Install core
```
#!/usr/bin/env bash
#install_core_helm.sh
export DOMAIN_NAME=cloudbees.core.pscbdemos.com
helm install --name cloudbees-core \
    --set OperationsCenter.HostName=${DOMAIN_NAME} \
    --set OperationsCenter.Ingress.tls.Enable=true \
    --set OperationsCenter.Ingress.tls.SecretName='cloudbees-core-tls' \
    --namespace='cloudbees-core' \
    cloudbees/cloudbees-core
```

