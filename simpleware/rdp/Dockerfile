FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /usr/sbin/simpleware
ENV SSH_PW sshpassowrd
RUN mkdir -p $HOME
COPY src $HOME

# init base env 
RUN chmod +x $HOME/startup.sh \
        && cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update \
        && apt-get install -y apt-utils dialog

RUN apt-get install -y \ 
	apt-utils python supervisor vim-tiny openssh-server sshpass wget

RUN apt-get install -y \
	# xfce and destop app.
	xfce4 xfce4-goodies firefox xterm \ 
	# vncserver
	x11vnc xvfb xserver-xorg-core xinit \
	# xrdp
	xrdp lxde lxdm

# config xrdp
RUN useradd -mp pasl8SZvzQP6k -s /bin/bash -G sudo sw
RUN xrdp-keygen xrdp auto \
	&& cp $HOME/lxcleanup.sh /bin/lxcleanup.sh \
	&& chmod +x /bin/lxcleanup.sh \
	&& echo '@lxcleanup.sh' >> /etc/xdg/lxsession/LXDE/autostart \
        && echo xfce4-session >~/.xsession \
	&& sed -i '/fi/a xfce4-session' /etc/xrdp/startwm.sh \
	&& cp $HOME/xrdp.conf /etc/supervisor/conf.d/xrdp.conf \
	&& cp $HOME/xfce.conf /etc/supervisor/conf.d/xfce.conf

EXPOSE 3389
ENTRYPOINT $HOME/startup.sh
