#!/bin/bash
docker container stop es_dev && docker container rm es_dev
docker container stop kibana_dev && docker container rm kibana_dev
docker container stop logstash_dev && docker container rm logstash_dev
docker run \
    --name es_dev \
    -d \
    -p 9200:9200 \
    -p 9300:9300 \
    -e "discovery.type=single-node" \
    docker.elastic.co/elasticsearch/elasticsearch-oss:7.9.3 

docker run \
    --name kibana_dev \
    -d \
    -e KIBANA_HOST=0.0.0.0 \
    -e ES_URL=http://elasticsearch:9200 \
    -p 5601:5601 \
    --link es_dev:elasticsearch \
    raquette/kibana-oss:7.9.3

docker run \
    --name logstash_dev \
    -d \
    -v ${PWD}/pipeline:/pipeline \
    --link es_dev:elasticsearch \
    raquette/logstash-oss:7.9.3

