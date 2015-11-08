#!/bin/sh
hosts_file="/etc/hosts"
resolv_file="/etc/resolv.conf"
hostname_file="/etc/hostname"
sysctl_file="/etc/sysctl.conf"
docker_conf_dir="/etc/openstack-docker"
log_file="/var/log/startup.log"
init_spt_dir="/etc/rc_docker_init/"
exec_spt_dir="/etc/rc_docker_exec"

echo `date` " Start to startup the docker container." >> $log_file

if [ ! -d $docker_conf_dir ]; then
    echo `date` " Warning: $docker_conf_dir is not exist, create it now." >> $log_file
    mkdir -p $docker_conf_dir
fi

if [ -f ${docker_conf_dir}/hosts ];then
    cat ${docker_conf_dir}/hosts > ${hosts_file}
    echo `date` " reset hosts to $hosts_file" >> $log_file
fi

if [ -f ${docker_conf_dir}/resolv.conf ];then
    cat ${docker_conf_dir}/resolv.conf > ${resolv_file}
    echo `date` " reset resolv.conf to $resolv_file" >> $log_file
fi

if [ -f ${docker_conf_dir}/hostname ];then
    cat ${docker_conf_dir}/hostname > ${hostname_file}
    hostname `cat $hostname_file`
    echo `date` " reset hostname to $hostname_file" >> $log_file
fi

if [ -f ${docker_conf_dir}/sysctl.conf ];then
    cat ${docker_conf_dir}/sysctl.conf > ${sysctl_file}
    echo `date` " reset sysctl to $sysctl_file" >> $log_file
fi

for script in `ls $init_spt_dir`; do  
    if [ -x $init_spt_dir/$script ]; then 
        eval $init_spt_dir/$script
    fi
done
rm -rf $init_spt_dir/*

for script in `ls $exec_spt_dir`; do  
    if [ -x $exec_spt_dir/$script ]; then 
        eval $exec_spt_dir/$script
    fi
done

echo `date` " Finish start Docker contianer.:)" >> $log_file
