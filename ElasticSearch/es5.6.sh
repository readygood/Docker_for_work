#!/bin/bash
docker container run --name es5.6 \
--network host  \
-v /root/elk/conf/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /root/elk/data/:/usr/share/elasticsearch/data/ \
-v /root/elk/logs/:/usr/share/elasticsearch/logs/  \
-p 9200:9200 \
-p 9300:9300 \
-d --rm docker.io/elasticsearch:5.6

docker container run --name es-head -p 9100:9100 --rm mobz/elasticsearch-head:5
