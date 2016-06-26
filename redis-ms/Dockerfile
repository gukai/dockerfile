FROM centos67:v2
ADD redis-3.0.7.tar.gz /usr/src/
ADD redis.conf /usr/local/
ADD entrypoint.sh /
RUN make -C /usr/src/redis-3.0.7 && make -C /usr/src/redis-3.0.7 install && cp /usr/src/redis-3.0.7/src/redis-trib.rb /usr/local/bin/
RUN chmod +x /entrypoint.sh
VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["/entrypoint.sh"]
