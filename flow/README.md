# SKO Prereqs

```
helm install --namespace flow --name mysqlflow stable/mysql
```

* Using values

```
helm install --name mysqlflow -f mysql.yaml --namespace flow stable/mysql
```

* below is not needed if you have used the mysql.yaml file, this created the database and user

```
kubectl run -i --tty ubuntu --image=ubuntu:16.04 -n flow --restart=Never -- bash -il
apt-get update && apt-get install mysql-client -y
mysql -h mysqlflow -p <password>

```



```
mysql>
mysql> CREATE DATABASE flow CHARACTER SET utf8 COLLATE utf8_general_ci;
mysql> CREATE USER 'flow-user'@'%' IDENTIFIED BY '<enter password>';
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