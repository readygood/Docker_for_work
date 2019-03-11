#!/bin/bash
docker container run --name kibana \
-v /etc/kibana/kibana.yml:/etc/kibana/kibana.yml  \
--network host \
-p 5601:5601 -d \
--rm kibana:5.6
