# Kibana Docker Image

Mixed architecture kibana image


```
docker \
    --name kibana_dev \
    -d \
    -e KIBANA_HOST=0.0.0.0 \
    -e ES_URL=http://elasticsearch:9200 \
    -p 5601:5601 \
    raquette/kibana-oss:7.9.3

```


