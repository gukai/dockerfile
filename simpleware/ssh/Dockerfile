FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV HOME /usr/sbin/simpleware
ENV SSH_PW sshpassowrd
RUN mkdir -p $HOME 
COPY src $HOME

# init base env
RUN chmod +x $HOME/startup.sh \
	&& cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update \
	&& apt-get install -y apt-utils

RUN apt-get install -y  --no-install-recommends \
	apt-utils python supervisor vim-tiny openssh-server sshpass wget

# config sshd
RUN mkdir -p /root/.ssh && chown root.root /root \
	&& chmod 700 /root/.ssh \
	&& touch /root/.ssh/authorized_keys \
	&& chmod 600 /root/.ssh/authorized_keys \
        && mkdir -p /var/run/sshd \
	&& sed  -i "/^[^#]*PermitRootLogin/ s/.*/#&/"  /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

EXPOSE 22
ENTRYPOINT $HOME/startup.sh
