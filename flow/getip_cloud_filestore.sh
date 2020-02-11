FS=flowcfs
PROJECT=stu-brown-ps
ZONE=us-east1-b
FSADDR=$(gcloud beta filestore instances describe ${FS} \
     --project=${PROJECT} \
     --zone=${ZONE} \
     --format="value(networks.ipAddresses[0])")

echo ${FSADDR}
