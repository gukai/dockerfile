# Apache Zookeeper

FROM debian:jessie
ENV ZOOKEEPER_VERSION 3.4.5

RUN apt-get update && apt-get install -y curl openjdk-7-jre-headless
COPY zookeeper-3.4.5.tar.gz /opt/
RUN tar xzf /opt/zookeeper-3.4.5.tar.gz -C /opt && mv /opt/zookeeper-3.4.5 /opt/zookeeper
RUN groupadd -r zookeeper \
  && useradd -c "Zookeeper" -d /var/lib/zookeeper -g zookeeper -M -r -s /sbin/nologin zookeeper \
  && mkdir /var/lib/zookeeper \
  && chown -R zookeeper:zookeeper /var/lib/zookeeper

COPY start.sh /usr/local/sbin/start.sh
RUN chmod +x /usr/local/sbin/start.sh
ENTRYPOINT ["/usr/local/sbin/start.sh"]
