#!/bin/bash
if [[ ${redis_type} == "local" ]]; then
    redis-server /usr/local/redis.conf
elif [[ ${redis_type} == "master" ]]; then
    redis-server /usr/local/redis.conf
elif [[ ${redis_type} == "slave" ]]; then
    if [[ ${GET_HOSTS_FROM:-dns} == "env" ]]; then
        redis-server /usr/local/redis.conf --slaveof ${REDIS_MASTER_SERVICE_HOST} 6379
    else
        redis-server /usr/local/redis.conf --slaveof redis-master 6379
    fi
elif [[ ${redis_type} == "cluster" ]]; then
    redis-server /usr/local/redis_cluster.conf
else
    redis-server $1
fi
