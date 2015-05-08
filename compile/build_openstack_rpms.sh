#!/bin/sh
image_name="test"
image_version="v5"
image="${image_name}:${image_version}"

#install docker-io rpm
rpm -q docker-io > /dev/null 2>&1
if [ "$?" != "0" ]; then
    yum install -y docker-io > /dev/null 2>&1
    if [ "$?" != "0" ]; then echo "ERROR: Failed to install docker-io, you must install it manually first."; exit; fi
fi

#start the docker daemon
/etc/init.d/docker start > /dev/null
/etc/init.d/docker status > /dev/null
if [ "$?" != "0" ];then
    echo "ERROR: Could not start docker, Fix it manually first."
fi

#load target image
docker images $image_name | grep $image_version > /dev/null
if [ "$?" != "0" ];then
    if [ ! -f /root/${image_name}-${image_version}.tar ];then
        echo "ERROR: docker image ${image_name}:${image_version} is not exist, put ${image_name}-${image_version}.tar to /root dir, and exec this script again."
        exit 1
    fi
    docker load < /root/${image_name}-${image_version}.tar
fi

#make sure that no other build container is running.
docker ps | awk '{print $2}'| sed -n '2,$p'| grep $image_name > /dev/null 2>&1
if [ "$?" = "0" ];then
   echo "ERROR: Another compile container is running now, please stop it first."
   exit 1
fi

#run docker and report
docker run --rm --attach stdout -v /root/rpmbuild/:/root/rpmbuild/ ${image_name}:${image_version}
if [ "$?" != "0" ];then
    echo "************************************************************************************"
    echo "************************************************************************************"
    echo "************************************************************************************"
    echo "ERROR: build failed."
    exit 1
fi

echo "************************************************************************************"
echo "************************************************************************************"
echo "************************************************************************************"
echo "Build Openstack RPM Successfully !"

