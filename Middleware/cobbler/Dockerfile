#mkimage-centos.sh centos:6.5
#docker build -t="suning/cobbler:v1" .
FROM centos:6.5

ADD RPM/cobbler-2.6.3-1.el6.noarch.rpm /tmp/
RUN rpm -ivh /tmp/cobbler-2.6.3-1.el6.noarch.rpm && rm -f /tmp/cobbler-2.6.3-1.el6.noarch.rpm



