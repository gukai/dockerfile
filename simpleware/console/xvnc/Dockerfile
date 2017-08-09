FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /usr/sbin/simpleware
ENV SSH_PW sshpassowrd
RUN mkdir -p $HOME
COPY src $HOME

# init baes env 
RUN chmod +x $HOME/startup.sh \
        && cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update \
        && apt-get install -y apt-utils dialog

RUN apt-get install -y \ 
	apt-utils python supervisor vim-tiny openssh-server sshpass wget

RUN apt-get install -y xfce4 firefox xterm 

RUN apt-get install -y x11vnc xvfb

# config xrdp
RUN cp $HOME/xvnc.conf /etc/supervisor/conf.d/xvnc.conf \
	&& cp $HOME/xfce.conf /etc/supervisor/conf.d/xfce.conf

EXPOSE 5900
ENTRYPOINT $HOME/startup.sh
