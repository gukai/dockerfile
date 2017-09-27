From centos:6.5

#install epel and openstack repo.
#RUN rpm -ivh http://mirrors.zju.edu.cn/epel//epel-release-latest-6.noarch.rpm 
#RUN rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/rdo-release-icehouse-4.noarch.rpm
#RUN rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-juno/rdo-release-juno-1.noarch.rpm

RUN rm -f /etc/yum.repos.d/*
ADD local_openstack_juno.repo /etc/yum.repos.d/

RUN yum install -y git tar wget rpm-build intltool glibc 

RUN yum install -y python-jinja2-26 python-setuptools python-pbr python-d2to1 python2-devel python-netaddr graphviz python-eventlet python-routes python-sqlalchemy python-webob python-migrate python-iso8601 python-boto python-stevedore python-argparse python-httplib2 python-kombu python-lxml python-memcached python-qpid PyYAML m2crypto libart_lgpl python-paramiko python-paste-deploy  python-oslo-sphinx python-docutils python-pygments sphinx python-sphinx python-sqlalchemy python-oslo-i18n python-oslo-db python-oslo-messaging python-oslo-serialization python-oslo-utils


RUN yum install -y python-glanceclient python-keystoneclient python-novaclient python-neutronclient python-cinderclient python-swiftclient python-heatclient python-ceilometerclient python-troveclient python-saharaclient

RUN yum install -y python-sphinx python-pygments --enablerepo openstack-dependency
RUN yum install -y python-oslo-sphinx graphviz --enablerepo devel-tools

RUN yum install -y python-sphinxcontrib-httpdomain python-sphinx10 python-paste-deploy1.5 python-routes1.12 python-sqlalchemy0.7 python-django python-lockfile python-django-openstack-auth python-django-compressor python-django-appconf python-lesscpy python-django-pyscss python-XStatic python-XStatic-jQuery python-XStatic-Angular  python-XStatic-Angular-Cookies python-XStatic-Angular-Mock python-XStatic-D3 python-XStatic-Font-Awesome python-XStatic-Hogan python-XStatic-JQuery-Migrate python-XStatic-JQuery.TableSorter python-XStatic-JQuery.quicksearch python-XStatic-JSEncrypt python-XStatic-Jasmine python-XStatic-QUnit python-XStatic-Rickshaw  python-XStatic-Spin python-XStatic-jquery-ui python-XStatic-Bootstrap-Datepicker python-XStatic-Bootstrap-SCSS openstack-utils python-dateutil


RUN pip install mox

ADD ssh /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/known_hosts
ADD build_bb.sh /usr/bin/

ENTRYPOINT ["/usr/bin/build_bb.sh"]
 
