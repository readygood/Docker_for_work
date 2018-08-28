#!/bin/bash

docker container run --name redis \
-v /root/redis/conf/redis.conf:/usr/local/etc/redis/redis.conf \
-v /root/redis/log/redis.log:/var/log/redis/redis.log \
-v /root/redis/run/redis.pid:/var/run/redis/redis.pid \
-v /root/redis/data/:/data/  \
-p 6379:6379  --network host -d  \
docker.io/redis:4 redis-server /usr/local/etc/redis/redis.conf
