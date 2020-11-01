FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    wget \
    gosu

RUN chmod 777 /opt
RUN groupadd -g 1000 kibana && useradd kibana -u 1000 -g 1000
ARG VERSION=7.9.3
ARG KIBANA_ARCH=aarch64
RUN wget  https://artifacts.elastic.co/downloads/kibana/kibana-oss-$VERSION-linux-$KIBANA_ARCH.tar.gz
RUN tar -xf kibana-oss-$VERSION-linux-$KIBANA_ARCH.tar.gz -C /opt
RUN ln -s /opt/kibana-$VERSION-linux-$KIBANA_ARCH /opt/kibana
RUN chown -R kibana:kibana /opt/kibana  /opt/kibana-$VERSION-linux-$KIBANA_ARCH


COPY docker-entrypoint.sh /usr/bin
RUN ln -s /opt/kibana/bin/kibana /usr/bin
#RUN ln -s /usr/local/bin/docker-entrypoint.sh
COPY kibana.yaml /kibana/config/
WORKDIR /opt/kibana
VOLUME /kibana/config
EXPOSE 5601

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kibana", "-c", "/kibana/config/kibana.yaml"]

