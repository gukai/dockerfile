#! /usr/bin/env bash

# Fail hard and fast
set -eo pipefail

setId(){
    ZOOKEEPER_ID=${ZOOKEEPER_ID:-1}
    echo "ZOOKEEPER_ID=$ZOOKEEPER_ID"

    #echo $ZOOKEEPER_ID > /opt/zookeeper/data/myid
    echo $ZOOKEEPER_ID > /var/lib/zookeeper/myid
}

setConfig(){
    ZOOKEEPER_TICK_TIME=${ZOOKEEPER_TICK_TIME:-2000}
    echo "tickTime=${ZOOKEEPER_TICK_TIME}" > /opt/zookeeper/conf/zoo.cfg
    #echo "tickTime=${ZOOKEEPER_TICK_TIME}"

    ZOOKEEPER_INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-10}
    echo "initLimit=${ZOOKEEPER_INIT_LIMIT}" >> /opt/zookeeper/conf/zoo.cfg
    #echo "initLimit=${ZOOKEEPER_INIT_LIMIT}"

    ZOOKEEPER_SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-5}
    echo "syncLimit=${ZOOKEEPER_SYNC_LIMIT}" >> /opt/zookeeper/conf/zoo.cfg
    #echo "syncLimit=${ZOOKEEPER_SYNC_LIMIT}"

    echo "dataDir=/var/lib/zookeeper" >> /opt/zookeeper/conf/zoo.cfg
    echo "clientPort=2181" >> /opt/zookeeper/conf/zoo.cfg

    ZOOKEEPER_CLIENT_CNXNS=${ZOOKEEPER_CLIENT_CNXNS:-300}
    echo "maxClientCnxns=${ZOOKEEPER_CLIENT_CNXNS}" >> /opt/zookeeper/conf/zoo.cfg
    #echo "maxClientCnxns=${ZOOKEEPER_CLIENT_CNXNS}"

    #ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT:-3}
    #echo "autopurge.snapRetainCount=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT}" >> /opt/zookeeper/conf/zoo.cfg
    #echo "autopurge.snapRetainCount=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT}"
    #
    #ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL:-0}
    #echo "autopurge.purgeInterval=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL}" >> /opt/zookeeper/conf/zoo.cfg
    #echo "autopurge.purgeInterval=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL}"

    #set zk member for configfile.
    python /k8s-cookie/app_tools/zookpeer.py
}


startZookpeer(){
    su zookeeper -s /bin/bash -c "/opt/zookeeper/bin/zkServer.sh start-foreground"
}

#Main
if [ ! -e /var/lib/zookeeper/myid ]; then
    setId
    echo "set Zookpeer ID in /var/lib/zookeeper/myid"
fi

if [ ! -e /opt/zookeeper/conf/zoo.cfg ]; then
    setConfig
    echo "set Zookpeer Config  in /opt/zookeeper/conf/zoo.cfg"
fi

startZookpeer


