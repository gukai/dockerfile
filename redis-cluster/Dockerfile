FROM centos67:v2
ADD redis-3.0.7.tar.gz /usr/src/
ADD CONF /usr/local/
ADD entrypoint.sh /
RUN make -C /usr/src/redis-3.0.7 && make -C /usr/src/redis-3.0.7 install && cp /usr/src/redis-3.0.7/src/redis-trib.rb /usr/local/bin/
RUN sed -i "/yes_or_die \"Can I set the above configuration?\"/ s/.*/#&/"  /usr/local/bin/redis-trib.rb

#for redis-trib.rb
RUN yum install -y ruby rubygems
RUN gem install redis

RUN chmod +x /entrypoint.sh
VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["/entrypoint.sh"]
