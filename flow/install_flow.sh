#!/usr/bin/env bash
helm install cloudbees/cloudbees-flow --name flow-server --set images.tag=2020.1.0.140629_1.0.10_20200131 -f cloudbees-flow-prod.yaml --namespace flow --timeout 10000
