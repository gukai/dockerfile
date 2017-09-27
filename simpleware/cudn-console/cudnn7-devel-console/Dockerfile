FROM nvidia/cuda:8.0-cudnn7-devel

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /usr/sbin/simpleware
ENV SSH_PW sshpassoword
RUN mkdir -p $HOME
COPY src $HOME
ENV NO_VNC_HOME $HOME/noNVC
ENV VNC_PW vncpassword
ENV VNC_PORT 5900
ENV NO_VNC_PORT 6900

# init baes env 
RUN chmod +x $HOME/startup.sh \
        && cp $HOME/sources.list /etc/apt/sources.list

RUN apt-get update \
        && apt-get install -y apt-utils dialog

RUN apt-get install -y \ 
	apt-utils python supervisor vim-tiny openssh-server sshpass wget net-tools

# xfce and destop app.
RUN apt-get install -y xfce4 xfce4-goodies firefox xterm xfonts-wqy

# vncserver
RUN apt-get install -y x11vnc xvfb xserver-xorg-core xinit
	
# xrdp
RUN apt-get install -y xrdp lxde lxdm

# config sshd
RUN mkdir -p /root/.ssh && chown root.root /root \
        && chmod 700 /root/.ssh \
        && touch /root/.ssh/authorized_keys \
        && chmod 600 /root/.ssh/authorized_keys \
        && mkdir -p /var/run/sshd \
        && sed  -i "/^[^#]*PermitRootLogin/ s/.*/#&/"  /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
        && cp $HOME/sshd.conf /etc/supervisor/conf.d/ssh.conf

# config vnc
RUN cp $HOME/xvnc.conf /etc/supervisor/conf.d/xvnc.conf \
	&& cp $HOME/xfce.conf /etc/supervisor/conf.d/xfce.conf

# install novnc/websockify
RUN mkdir -p $NO_VNC_HOME/utils/websockify \
	&& wget --no-check-certificate -qO- https://github.com/kanaka/noVNC/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
        && wget --no-check-certificate -qO- https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
        && chmod +x -v $NO_VNC_HOME/utils/*.sh \
        ## create index.html to forward automatically to `vnc_auto.html`
        && ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html \
	&& cp $HOME/novnc.conf /etc/supervisor/conf.d/novnc.conf

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

EXPOSE 22
EXPOSE 3389
EXPOSE $VNC_PORT
EXPOSE $NO_VNC_PORT
ENTRYPOINT $HOME/startup.sh
