#!/usr/bin/env bash
#install_core_helm.sh
export DOMAIN_NAME=cloudbees.core.pscbdemos.com
helm install --name cloudbees-core \
    --set OperationsCenter.HostName=${DOMAIN_NAME} \
    --set OperationsCenter.Ingress.tls.Enable=true \
    --set OperationsCenter.Ingress.tls.SecretName='cloudbees-core-tls' \
    --namespace='cloudbees-core' \
    cloudbees/cloudbees-core
