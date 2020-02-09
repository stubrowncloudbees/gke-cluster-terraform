helm install --namespace ingress-nginx \
             --name nginx-ingress stable/nginx-ingress \
             --values values.yaml \
             --version 1.4.0
