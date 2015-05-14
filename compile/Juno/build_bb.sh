#!/bin/bash
#os_version is the openstack version, icehouse set master, juno set juno.
os_version="juno"
git_home="/tmp/openstack-sn"
now_dir=`pwd`
build_dir="/root/rpmbuild/"
projs="openstack-ceilometer python-ceilometerclient openstack-cinder python-cinderclient openstack-glance python-glanceclient openstack-heat python-heatclient python-django-horizon openstack-keystone python-keystoneclient openstack-nova python-novaclient openstack-neutron python-neutronclient openstack-sahara python-saharaclient openstack-trove python-troveclient python-oslo-messaging"


clean_build_env(){

    if [ ! -d ${build_dir} ];then
        mkdir -p ${build_dir}
    else
        rm -rf ${build_dir}/*
    fi
    mkdir ${build_dir}/SOURCES
    mkdir ${build_dir}/SPECS
}

clean_git_env(){
    if [ -d $git_home ];then
        rm -rf $git_home
    fi
    mkdir -p $git_home
}


get_clr_proj(){
    local proj="$1"
    local clr_os_proj=${proj#openstack-}
    local clr_py_proj=${clr_os_proj#python-}
    local clr_dj_proj=${clr_py_proj#django-}
    local clr_client_proj=${clr_dj_proj%client}
    local clr_proj=$clr_client_proj
    echo $clr_proj
}

get_proj_dir(){
    proj="$1"
    cd ${git_home}/${proj}/
    local proj_dir_name=`find ./ -maxdepth 1 | grep ${clr_proj}-* | grep -v spec | cut -d'/' -f 2`
    echo $proj_dir_name
}

get_git_code(){
    local proj="$1"
    cd $git_home
    
    if [ ! -f ${git_home}/${proj}/.git ];then
        git clone root@10.27.37.51:/data/openstack-sn/$proj
        if [ "$?" != "0" ];then
          echo "error while git clone $proj"
          exit 1
        fi
    fi

    cd ${git_home}/${proj}/

    git checkout $os_version
    if [ "$?" != "0" ];then
      echo "error while git checkout master $proj"
      exit 1
    fi
    
    git pull
    if [ "$?" != "0" ];then
      echo "error while git pull master $proj"
      exit 1
    fi
}

set_build_env(){
    local proj="$1"
    cd ${git_home}/${proj}/
    proj_dir_name=`get_proj_dir $proj`

    tar -zcvf /root/rpmbuild/SOURCES/${proj_dir_name}.tar.gz ${proj_dir_name}
    if [ "$?" != "0" ];then
      echo "error while tar the dir: $proj_dir_name for proj: $proj."
      exit 1
    fi
    cp ${git_home}/${proj}/${proj}.spec /root/rpmbuild/SPECS/    
    cp ${git_home}/${proj}/patch/* /root/rpmbuild/SOURCES/ 
}

real_build(){
    local proj="$1"
    rpmbuild -ba /root/rpmbuild/SPECS/${proj}.spec --without doc
    if [ "$?" != "0" ];then
        echo "ERROR**********************build  ${proj}****************************************ERROR"
        exit 1
    fi
}


#MAIN
if [ $# -gt 0 ];then projs=$@; fi
clean_build_env
clean_git_env

for proj in $projs; do
    clr_proj=`get_clr_proj $proj`
    get_git_code $proj 
    set_build_env $proj
    real_build $proj
done
cd $now_dir
