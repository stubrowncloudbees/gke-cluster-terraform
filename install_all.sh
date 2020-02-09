gcloud container clusters get-credentials stu-brown-ps-cluster --region us-east1
./install_helm.sh
./install_cluster_admin.sh
./create_ssd_storage.sh
./make_ssd_default.sh
./create_ns.sh
./install_ingress_manual.sh
./patch_replica_count.yaml
./create_certs.sh
./install_core_helm.sh

