#!/bin/bash
ip_list=""
for ip in `kubectl describe pod -l name=redis-cluster | grep IP: | grep 10.200 | awk '{print $2}'`;do
    ip_list="$ip_list ${ip}:6379"
done

echo "IP LIST $ip_list"
while true;do
    ping -c 1 $ip
    if [ $? == 0 ];then
       break
    fi
    sleep 1
    echo "wait for containers startup."
done
/usr/local/bin/redis-trib.rb create --replicas 1 $ip_list
