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


COPY kibana-docker /usr/bin
COPY docker-entrypoint.sh /usr/bin
WORKDIR /opt/kibana
EXPOSE 5601

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kibana-docker"]

