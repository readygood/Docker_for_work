#!/bin/bash

docker container run --name filebeat --network host \
-v /root/filebeat/conf/filebeat.yml:/usr/share/filebeat/filebeat.yml \
-v /var/log/messages:/var/log/messages \
-v /var/log/nginx/access.log:/var/log/nginx/access.log  \
--rm -d docker.elastic.co/beats/filebeat:5.6.15 \
filebeat  -c /usr/share/filebeat/filebeat.yml
