#!/bin/bash
echo "root:123456" | chpasswd

/usr/bin/supervisord -c $HOME/supervisord.conf
