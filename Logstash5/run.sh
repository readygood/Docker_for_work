#!/bin/bash
docker container run --name logstash \
-p 9600:9600  \
-v /var/log/nginx/access.log:/var/log/nginx/access.log \
-v /var/log/messages:/var/log/messages  \
-v /root/logstash/pipeline/stdout.conf:/etc/logstash/conf.d/stdout.conf \
-d  --network host -it --rm docker.io/logstash:5.6  \
-f /etc/logstash/conf.d/stdout.conf
