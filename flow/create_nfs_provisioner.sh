#!/usr/bin/env bash
FSADDR=10.215.35.10
helm install stable/nfs-client-provisioner --namespace flow --name nfs-rwm --set nfs.server=${FSADDR} --set nfs.path=/volumes --set storageClass.name=flow-rwm
