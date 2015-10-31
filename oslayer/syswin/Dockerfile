#version: 0.5
#oslayer:version
#docker build -t="oslayer:version" .
#docker save dockerbase > oslayer-version.tar
#glance image-create --is-public=True --container-format=docker --disk-format=raw --name oslayer:version < oslayer-version.tar
From centos65:v1
MAINTAINER gukai gushenbusi@gmail.com

#add codes/packages/configurations
ADD os_config /tmp/
ADD RPMS /tmp/

#install RPMs necessarily
#RUN yum install -y python-crypto python-babel pciutils libyaml yum-utils libyaml zeromq3 python-jinja2 python-msgpack PyYAML salt-minion python-zmq salt sshpass wget tar perl unzip
RUN yum install -y bash openssl glibc tar wget unzip sshpass 
# fix passwd command err: /usr/share/cracklib/pw_dict.pwd: No such file or directory 
RUN yum reinstall -y cracklib-dicts
RUN mkdir -p /etc/yum.repos.d/bak && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak/ && cp /tmp/yum_repo/* /etc/yum.repos.d/

#config profile
RUN sed -i "/^HISTSIZE/ s/.*/#&/"  /etc/ssh/sshd_config && echo "HISTSIZE=1000" >> /etc/profile
RUN sed -i "/^HISTTIMEFORMAT/ s/.*/#&/"  /etc/ssh/sshd_config && echo 'HISTTIMEFORMAT="%T %F "' >> /etc/profile
RUN sed -i "/^TMOUT/ s/.*/#&/"  /etc/ssh/sshd_config && echo "TMOUT=300" >> /etc/profile

#system login safe config
RUN sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS  90/' /etc/login.defs
RUN sed -i 's/PASS_MIN_LEN.*/PASS_MIN_LEN  8/' /etc/login.defs
RUN sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_LEN  0/' /etc/login.defs
RUN sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE  7/' /etc/login.defs

#config pam
RUN sed -i "/^[^#]*auth[\ ,-t]*required/ s/.*/#&/"  /etc/pam.d/su
RUN sed -i "/password[\ ,-t]*requisite[\ ,-t]*pam_cracklib.so/d" /etc/pam.d/system-auth
RUN sed -i "/password[\ ,-t]*sufficient[\ ,-t]*pam_unix.so/i password    requisite     pam_cracklib.so minlen=8 ucredit=-2 lcredit=-2   dcredit=-2 ocredit=-1" /etc/pam.d/system-auth

# config ssh 
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys
RUN cp /tmp/ssh/* /root/.ssh/
RUN cat /root/.ssh/syswin.keys >> /root/.ssh/authorized_keys && rm -f /root/.ssh/syswin.keys
RUN echo 'root:123456' | chpasswd
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config && echo "UsePAM yes" >> /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*UseDNS/ s/.*/#&/"  /etc/ssh/sshd_config && echo "UseDNS no" >> /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*UseLogin/ s/.*/#&/"  /etc/ssh/sshd_config && echo "UseLogin yes" >> /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*ClientAliveInterval/ s/.*/#&/"  /etc/ssh/sshd_config && echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*ClientAliveCountMax/ s/.*/#&/"  /etc/ssh/sshd_config && echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key


#Intrusion Detection
ADD safe/ossec-client.tar.gz /usr/local
RUN useradd -d /usr/local/ossec -s /sbin/nologin ossec && chown -R ossec.ossec /usr/local/ossec-client


#set ulimit
RUN cp /tmp/90-nproc.conf /etc/security/limits.d/90-nproc.conf
#config supervisord
RUN rpm -ivh /tmp/supervisor-2.1-8.el6.noarch.rpm /tmp/python-meld3-0.6.7-1.el6.x86_64.rpm && cp /tmp/supervisord.conf /etc/supervisord.conf

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n

#init script and command.
RUN mkdir -p /var/log/supervisor && mkdir -p /etc/openstack-docker
RUN cp /tmp/startup.sh /bin/startup.sh && chmod +x /bin/startup.sh
CMD /bin/startup.sh && sysctl -p && supervisord

#clean
RUN rm -rf /tmp/*
