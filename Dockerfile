FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    wget \
    gosu

RUN chmod 777 /opt
RUN groupadd -g 1000 kibana && useradd kibana -u 1000 -g 1000
ARG VERSION=edge
ARG KIBANA_VERSION=7.9.3
ARG TARGETPLATFORM
RUN wget  https://artifacts.elastic.co/downloads/kibana/kibana-oss-$KIBANA_VERSION-linux-$(echo $TARGETPLATFORM|cut -d/ -f2|sed -e "s/arm64/aarch64/"|sed -e "s/amd64/x86_64/").tar.gz
RUN tar -xf kibana-oss-$KIBANA_VERSION-linux-$(echo $TARGETPLATFORM|cut -d/ -f2|sed -e "s/arm64/aarch64/"|sed -e "s/amd64/x86_64/").tar.gz -C /opt
RUN ln -s /opt/kibana-$KIBANA_VERSION-linux-$(echo $TARGETPLATFORM|cut -d/ -f2|sed -e "s/arm64/aarch64/"|sed -e "s/amd64/x86_64/" ) /opt/kibana
RUN chown -R kibana:kibana /opt/kibana  /opt/kibana-$KIBANA_VERSION-linux-$(echo $TARGETPLATFORM|cut -d/ -f2|sed -e "s/arm64/aarch64/"|sed -e "s/amd64/x86_64/")


COPY kibana-docker /usr/bin
COPY docker-entrypoint.sh /usr/bin
COPY --chown=1000:0 kibana.yml /opt/kibana/config/kibana.yml

WORKDIR /opt/kibana
RUN chmod -R g=u /opt/kibana
RUN find /opt/kibana -type d -exec chmod g+s {} \;
EXPOSE 5601

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kibana-docker"]

