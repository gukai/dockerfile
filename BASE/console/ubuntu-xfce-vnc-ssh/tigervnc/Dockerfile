FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV HOME /usr/sbin/simpleware
ENV SSH_PW sshpassowrd
RUN mkdir -p $HOME
COPY src $HOME

# init baes env 
RUN chmod +x $HOME/startup.sh \
        && cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update \
        && apt-get install -y apt-utils

RUN apt-get install -y  --no-install-recommends \
        apt-utils python supervisor vim-tiny openssh-server sshpass wget
	
# install desktop packages.
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y  --no-install-recommends xfce4 firefox xterm 



# install VNC Packages
ENV NO_VNC_HOME $HOME/noVNC
ENV VNC_PW vncpassword
# install tigervnc or x11vnc
# tigervnc
RUN wget --no-check-certificate -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.7.0.x86_64.tar.gz | tar xz --strip 1 -C /
# x11vnc
#RUN apt-get install -y x11vnc xvfb && && apt-get clean -y


# install novnc/websockify
mkdir -p $NO_VNC_HOME/utils/websockify
RUN wget --no-check-certificate -qO- https://github.com/kanaka/noVNC/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
	&& wget --no-check-certificate -qO- https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
	&& chmod +x -v $NO_VNC_HOME/utils/*.sh \
	## create index.html to forward automatically to `vnc_auto.html`
	&& ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html

ENTRYPOINT $HOME/startup.sh
