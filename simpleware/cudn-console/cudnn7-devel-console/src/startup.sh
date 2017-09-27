#!/bin/bash
ldconfig
echo "root:${SSH_PW}" | chpasswd
x11vnc -storepasswd $VNC_PW /etc/x11vnc.pass

/usr/bin/supervisord -n
