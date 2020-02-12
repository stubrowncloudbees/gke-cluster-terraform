#!/usr/bin/env bash
helm install stable/nfs-client-provisioner --name nfs-rwm --set nfs.server=${FSADDR} --set nfs.path=/volumes --set storageClass.name=flow-rwm
