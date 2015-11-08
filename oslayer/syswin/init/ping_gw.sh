#!/bin/sh

while true;do
    ip route list | grep default >/dev/null 2>&1
    if [ $? -eq 0 ];then
        echo "Network: link setup successfully."
        break
    fi
    sleep 1
done

trys=0
while [ $trys -le 200 ];do
    gw=`ip route list | grep default | cut -d' ' -f3`
    ping $gw -c 1 > /dev/null 2>&1
    if [ $? -eq 0 ];then
        echo "Network: L3 setup successfully."
        break
    fi
    i=`expr $trys + 1`
    sleep 1
done

if [ $trys -ge 200 ];then
    echo "Network: L3 setup failed."
fi
        


