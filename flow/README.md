# SKO Prereqs

```
helm install --namespace flow --name mysqlflow stable/mysql
```

see mysql.md

```
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace flow mysqlflow -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)
echo $MYSQL_ROOT_PASSWORD
```
GsiApdblx5
```
kubectl run -i --tty ubuntu --image=ubuntu:16.04 -n flow --restart=Never -- bash -il
apt-get update && apt-get install mysql-client -y
mysql -h mysqlflow -p GsiApdblx5

```



```
mysql>
mysql> CREATE DATABASE flow CHARACTER SET utf8 COLLATE utf8_general_ci;
mysql> CREATE USER 'flow-user'@'%' IDENTIFIED BY 'R5CrqMkE4wC3CGJz';
mysql> GRANT ALL PRIVILEGES ON * . * TO 'flow-user'@';

```

```
helm install --name elasticsearch elastic/elasticsearch --namespace  flow
helm test elasticsearch

```


SHOW DATABASES;

ALTER USER 'flow-user'@'localhost' IDENTIFIED BY 'R5CrqMkE4wC3CGJz';

ingress.certificate.key=helm install cloudbees/cloudbees-flow --name flow-server -f flow-values-sko.yaml --namespace flow --timeout 10000 --set-file ingress.certificate.key=key.pem --set-file ingress.certificate.crt=cert.pem