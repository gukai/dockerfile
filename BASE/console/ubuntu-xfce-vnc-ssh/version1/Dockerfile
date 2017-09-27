FROM ubuntu:16.04

MAINTAINER Wen Chou "gukai@simpleware.com.cn"

# Config Base ENV and Workdir
#ENV HOME /headless
#ENV INST_SCRIPTS $HOME/install
#WORKDIR $HOME

# install all packages.
RUN apt-get update \
        # base packages.
	&& apt-get install -y supervisor vim-tiny openssh-server wget net-tools \
        # desktop packages
        && apt-get install -y xfce4 xfce4-goodies firefox
        # x11nvc packages
        #&& apt-get install -y x11vnc xvfb
        # clean apt env.
	&& apt-get clean -y


CMD /usr/bin/supervisord -c /root/supervisord.conf
