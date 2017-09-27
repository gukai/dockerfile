#!/bin/bash
#(echo $VNC_PW && echo $VNC_PW) | vncpasswd
echo "root:123456" | chpasswd

/usr/bin/supervisord -c $HOME/supervisord.conf
