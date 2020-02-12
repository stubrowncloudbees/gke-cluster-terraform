# SKO Prereqs

```
helm install --namespace flow --name mysqlflow stable/mysql
```

see mysql.md

```
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace flow mysqlflow -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)
echo $MYSQL_ROOT_PASSWORD
```
1q5HbfBftZ
```
kubectl run -i --tty ubuntu --image=ubuntu:16.04 -n flow --restart=Never -- bash -il
apt-get update && apt-get install mysql-client -y
mysql -h mysqlflow -p 1q5HbfBftZ

```



```ç
mysql>
mysql> CREATE DATABASE flow CHARACTER SET utf8 COLLATE utf8_general_ci;
mysql> CREATE USER 'flow-user'@'%' IDENTIFIED BY 'R5CrqMkE4wC3CGJz';
mysql> GRANT ALL PRIVILEGES ON * . * TO 'flow-user'@'%';

```

```
helm install --name elasticsearch elastic/elasticsearch --namespace  flow
helm test elasticsearch

```
```
./create_cloud_filestore.sh
```
```
./getip_cloud_filestore.sh
```
```
./create_nfs_provisioner.sh
```
```
./install_flow.sh
```