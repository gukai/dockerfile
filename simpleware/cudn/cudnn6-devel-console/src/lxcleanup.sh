#!/bin/bash
pgrep -U $(id -u) lxsession | grep -v ^$_LXSESSION_PID | xargs --no-run-if-empty kill
rm -f /var/run/xrdp/xrdp*.pid
