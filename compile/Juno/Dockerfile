From centos:6.5

#install epel and openstack repo.
RUN rpm -ivh http://mirrors.zju.edu.cn/epel//epel-release-latest-6.noarch.rpm 
RUN rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/rdo-release-icehouse-4.noarch.rpm
#RUN rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-juno/rdo-release-juno-1.noarch.rpm

RUN yum install -y git tar wget rpm-build intltool python-jinja2-26 python-setuptools python-pbr python-d2to1 python2-devel python-netaddr graphviz python-eventlet python-routes python-sqlalchemy python-webob python-migrate python-iso8601 python-boto python-stevedore python-argparse python-httplib2 python-kombu python-lxml python-memcached python-qpid PyYAML m2crypto python-paramiko python-paste-deploy python-sphinxcontrib-httpdomain python-oslo-sphinx

#install from rdo icehouse release : https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/rdo-release-icehouse-4.noarch.rpm
RUN yum install -y python-docutils python-pygments sphinx python-sphinx python-oslo-messaging python-sqlalchemy

#yum install -y help2man python-mako python-mock python-sqlalchemy0.7 python-nose1.1 python-psycopg2 MySQL-python python-nose python-scripttest python-testtools python-unittest2 

#compile from rdo juno release.
#python-oslo-i18n python-oslo-db python-oslo-messaging python-oslo-serialization python-oslo-utils python-migrate python-alembic python-oslo-config

RUN mkdir -p /tmp/SRPM/ && wget -P /tmp/SRPM https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-oslo-db-0.4.0-2.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-oslo-i18n-0.3.0-1.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-oslo-serialization-0.3.0-1.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-oslo-utils-0.3.0-1.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-migrate-0.9.1-1.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-alembic-0.6.5-3.el7.centos.src.rpm https://repos.fedorapeople.org/repos/openstack/openstack-juno/epel-7/python-oslo-config-1.4.0-1.el7.centos.src.rpm && rpm -ivh /tmp/SRPM/*.src.rpm && rm -rf /tmp/SRPM/
RUN for spec in `ls /root/rpmbuild/SPECS | grep 'spec'`; do rpmbuild -bb /root/rpmbuild/SPECS/$spec; if [ $? != 0 ];then echo "ERROR: compile $spec error.";exit 1;fi; done 


#RUN pip install mox

#ADD ssh /root/.ssh/
#RUN chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/known_hosts
#ADD build_bb.sh /usr/bin/

#CMD /usr/bin/build_bb.sh
 
