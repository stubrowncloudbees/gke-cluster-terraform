#!/usr/bin/env bash
helm install cloudbees/cloudbees-flow --name flow-server -f flow-values.yaml --namespace flow --timeout 10000 --set-file ingress.certificate.key=key.pem --set-file ingress.certificate.crt=cert.pem --set ingress.host="cloudbees.flow.pscbdemos.com"

