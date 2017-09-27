FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV HOME /usr/sbin/simpleware
ENV NO_VNC_HOME $HOME/noVNC
ENV VNC_PW vncpassword
ENV SSH_PW sshpassowrd

# init baes env 
RUN mkdir -p $NO_VNC_HOME/utils/websockify
COPY src $HOME/
RUN cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update
	
# necessory
# we need python2.7, but openssh-server need python-3.x
RUN apt-get install -y  --no-install-recommends apt-utils python supervisor vim-tiny openssh-server sshpass  

# optional in
# optional out: net-tools
RUN apt-get install -y  --no-install-recommends wget
 
# install desktop packages.
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y  --no-install-recommends xfce4 firefox xterm 
	# install rdp pacekages 1402M 
RUN apt-get install  -y --no-install-recommends xrdp lxde lxdm 

#RUN apt-get clean -y


# install tigervnc or x11vnc
# tigervnc
RUN wget --no-check-certificate -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.7.0.x86_64.tar.gz | tar xz --strip 1 -C /
# x11vnc
#RUN apt-get install -y x11vnc xvfb && && apt-get clean -y


# install novnc/websockify
RUN wget --no-check-certificate -qO- https://github.com/kanaka/noVNC/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
	&& wget --no-check-certificate -qO- https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
	&& chmod +x -v $NO_VNC_HOME/utils/*.sh \
	## create index.html to forward automatically to `vnc_auto.html`
	&& ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html


# config sshd
RUN mkdir -p /root/.ssh && chown root.root /root \
	&& chmod 700 /root/.ssh \
	&& touch /root/.ssh/authorized_keys \
	&& chmod 600 /root/.ssh/authorized_keys \
        && mkdir -p /var/run/sshd \
	&& sed  -i "/^[^#]*PermitRootLogin/ s/.*/#&/"  /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# config xrdp
RUN cp $HOME/lxcleanup.sh /bin/lxcleanup.sh \
	&& chmod +x /bin/lxcleanup.sh \
	&& echo '@lxcleanup.sh' >> /etc/xdg/lxsession/LXDE/autostart

RUN chmod +x $HOME/startup.sh
ENTRYPOINT $HOME/startup.sh
