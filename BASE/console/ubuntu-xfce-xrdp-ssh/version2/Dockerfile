FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

# Config Base ENV and Workdir
#ENV HOME /headless
#ENV INST_SCRIPTS $HOME/install
#WORKDIR $HOME


ENV HOME /usr/sbin/simpleware
ENV VNC_PW vncpassword
ENV SSH_PW sshpassowrd


# install all packages.
#RUN apt-get update \
#        # base packages.
#	&& apt-get install -y supervisor vim-tiny openssh-server wget net-tools \
#        # desktop packages
#        && apt-get install -y xfce4 firefox xterm
#        # x11nvc packages
#        #&& apt-get install -y x11vnc xvfb
#        # clean apt env.
#	&& apt-get clean -y

RUN apt-get update 

# necessory
# we need python2.7, but openssh-server need python-3.x
RUN apt-get install -y python supervisor vim-tiny openssh-server sshpass

# optional in
RUN apt-get install -y wget 

# optional out
# RUN apt-get install net-toolls

# install desktop packages.
RUN apt-get install -y xfce4 firefox xterm
RUN mkdir -p $HOME

# install and config sshd
RUN mkdir -p /root/.ssh && chown root.root /root \
	&& chmod 700 /root/.ssh \
	&& touch /root/.ssh/authorized_keys \
	&& chmod 600 /root/.ssh/authorized_keys \
        && mkdir -p /var/run/sshd \
	&& sed  -i "/^[^#]*PermitRootLogin/ s/.*/#&/"  /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# install tigervnc or x11vnc
# tigervnc
RUN wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.7.0.x86_64.tar.gz | tar xz --strip 1 -C /
# x11vnc
#RUN apt-get install -y x11vnc xvfb && && apt-get clean -y

# install novnc/websockify
ENV NO_VNC_HOME $HOME/noVNC
RUN mkdir -p $NO_VNC_HOME/utils/websockify \
	&& wget -qO- https://github.com/kanaka/noVNC/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
	&& wget -qO- https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
	&& chmod +x -v $NO_VNC_HOME/utils/*.sh \
	## create index.html to forward automatically to `vnc_auto.html`
	&& ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html


ADD src $HOME/
RUN chmod +x $HOME/startup.sh
ENTRYPOINT $HOME/startup.sh
