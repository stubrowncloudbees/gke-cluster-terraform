#!/usr/bin/env bash
helm install cloudbees/cloudbees-flow-agent --name flow-agent -f flow-agent.yaml --namespace flow --set resourceName="k8s-agent - {{ .Release.Name }} - {{ ordinalIndex }}" --set replicas=5
