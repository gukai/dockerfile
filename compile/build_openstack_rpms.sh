#!/bin/sh
OS_VERSION=""
registry="10.27.37.51:5000/"
ice_image_name="sn-ice-compile"
ice_image_version="v1"
juno_image_name="sn-juno-compile"
juno_image_version="v1"
image_name=""
image_version=""
projs_list=""

usage(){
    echo "$0 --version|-v <openstack_version> --projects [project list]"
    echo "    --version:  set the openstack version (icehouse,juno)"
    echo "    --projects: one or more projects to compile.(default is all projects)"
    echo "                put the project list in to one double-quote like: --projects \"openstack-heat openstack-nova\""
}

report(){
    ret="$1"
    echo "************************************************************************************"
    echo "************************************************************************************"
    echo "************************************************************************************"
    echo "INFO: Use ${image_name}:${image_version} to build $OS_VERSION RPM"
    if [ "$ret" = "success" ];then
        echo "INFO: Build Openstack RPM Successfully !"
        echo "INFO: Project list : $projs_list"
    else
        echo "ERROR: Build Openstack RPM Failed :("
    fi  
} 

TEMP=`getopt -o v:p:h --long version:,projects:,help, -n 'ERROR:' -- "$@"`
if [ $? != 0 ] ; then usage >&2 ; exit 1 ; fi
eval set -- "$TEMP"

while true ; do
        case "$1" in
                -v| --version) OS_VERSION=$2 ; shift 2 ;;
                -p| --projects) projs_list=$2 ; shift 2 ;;
                -h| --help) usage; exit 0; shift 2;;
                --) shift ; break ;;
                *) echo "Unknow Option, verfiy your command $1" ; usage; exit 1 ;;
        esac
done

if [ "$OS_VERSION" == "icehouse" ];then
        image_name=$ice_image_name
        image_version=$ice_image_version
elif [ "$OS_VERSION" == "juno" ];then 
        image_name=$juno_image_name
        image_version=$juno_image_version
else
        usage
        exit 1
fi



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
    docker pull ${registry}/${image_name}:${image_version}
    if [ "$?" != "0" ];then
        if [ ! -f /root/${image_name}-${image_version}.tar ];then
            echo "ERROR: Could not pull image from $registry"
            echo "ERROR: docker image ${image_name}:${image_version} is not exist, put ${image_name}-${image_version}.tar to /root dir, and exec this script again."
            exit 1
        fi
        docker load < /root/${image_name}-${image_version}.tar
    fi
fi

#make sure that no other build container is running.
docker ps | awk '{print $2}'| sed -n '2,$p'| grep $image_name > /dev/null 2>&1
if [ "$?" = "0" ];then
   echo "ERROR: Another compile container is running now, please stop it first."
   exit 1
fi

#run docker and report
if [ -z "$projs_list" ];then
    docker run --rm -v /root/rpmbuild/:/root/rpmbuild/ ${registry}/${image_name}:${image_version}
else
    docker run --rm -v /root/rpmbuild/:/root/rpmbuild/ ${registry}/${image_name}:${image_version} "$projs_list"
fi

if [ "$?" = "0" ];then
    report "success"
else
    report "failed"
fi

