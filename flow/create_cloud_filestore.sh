#!/usr/bin/env bash
FS=flowcfs
PROJECT=stu-brown-ps
ZONE=us-east1-b
gcloud beta filestore instances create ${FS} \
    --project=${PROJECT} \
    --zone=${ZONE} \
    --tier=STANDARD \
    --file-share=name="volumes",capacity=1TB \
    --network=name="default"
