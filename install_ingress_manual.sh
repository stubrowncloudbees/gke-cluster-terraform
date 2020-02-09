kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/provider/cloud-generic.yaml

kubectl patch deployment.apps/nginx-ingress-controller -p '{"spec":{"template":{"spec":{"nodeSelector":{"kubernetes.io/os":null}}}}}' -n ingress-nginx
kubectl patch deployment.apps/nginx-ingress-controller -p '{"spec":{"template":{"spec":{"nodeSelector":{"beta.kubernetes.io/os":"linux"}}}}}' -n ingress-nginx
