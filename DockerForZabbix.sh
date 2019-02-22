#!/bin/bash
yum install -y docker-ce php php-mysql
systemctl start docker
docker network create zabbix
cat >> /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://yry1etev.mirror.aliyuncs.com"]
}
EOF
systemctl restart docker
DB_NAME=zmysql-server
ZSVER_NAME=zabbix-server-mysql
ZNGX_NAME=zabbix-nginx
DB_VERS=5.7
ZSVER_VER=centos-3.0-latest
docker container run --name $DB_NAME \
--network zabbix \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e MYSQL_PASSWORD="123456" \
-e MYSQL_ROOT_PASSWORD="654321" \
-v /data/zabbix-mysql:/var/lib/mysql \
--rm -d mysql:$DB_VERS

DB_IP=`docker inspect zmysql-server | grep '"IPAddress"'|sed -n 2p|awk -F" " '{print $2}'|sed 's@"\|,@@g'`

docker container run --name $ZSVER_NAME \
--network zabbix -t \
-e DB_SERVER_HOST="$DB_IP" \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e MYSQL_PASSWORD="123456" \
-e MYSQL_ROOT_PASSWORD="654321" \
-p 10051:10051 \
--rm -d zabbix/zabbix-server-mysql:$ZSVER_VER

ZSEV_IP=`docker inspect zabbix-server-mysql | grep '"IPAddress"'|sed -n 2p|awk -F" " '{print $2}'|sed 's@"\|,@@g'`
 
docker container run --name $ZNGX_NAME \
--network zabbix -t \
-e DB_SERVER_HOST="$DB_IP" \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e ZBX_SERVER_HOST="$ZSEV_IP" \
-e MYSQL_PASSWORD="123456" \
-e MYSQL_ROOT_PASSWORD="654321" \
-e PHP_TZ="Asia/Shanghai" \
-p 80:80 --rm \
-d zabbix/zabbix-web-nginx-mysql:$ZSVER_VER
