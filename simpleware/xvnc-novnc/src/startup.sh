#!/bin/bash
echo "root:123456" | chpasswd
x11vnc -storepasswd $VNC_PW /etc/x11vnc.pass

$NO_VNC_HOME/utils/launch.sh --vnc 0.0.0.0:$VNC_PORT --listen $NO_VNC_PORT &
/usr/bin/supervisord -n
