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
