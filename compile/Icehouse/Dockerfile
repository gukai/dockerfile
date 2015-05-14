#docker build -t="test:v4" .
From centos:6.5

#install epel and openstack repo.
RUN rpm -ivh http://mirrors.zju.edu.cn/epel//epel-release-latest-6.noarch.rpm 
RUN rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/rdo-release-icehouse-4.noarch.rpm


#install deps.
RUN yum install -y git tar rpm-build intltool python-sphinx10 python-setuptools python-pbr python-d2to1 python2-devel python-sqlalchemy0.7 python-webob1.2 crudini  python-oslo-sphinx python-netaddr python-paste-deploy1.5 python-routes1.12 graphviz python-eventlet python-migrate python-iso8601 python-boto python-paste-deploy python-routes python-webob python-repoze-lru openstack-utils python-sphinx python-argparse python-httplib2 python-kombu python-lxml python-memcached python-qpid PyYAML m2crypto python-paramiko python-oslo-config python-cinderclient python-keystoneclient python-novaclient python-neutronclient python-swiftclient python-heatclient python-jinja2-26 dos2unix docutils python-pygments Django14 python-lockfile pytz python-django-openstack-auth python-django-compressor python-django-appconf python-lesscpy python-dateutil python-glanceclient python-ceilometerclient python-troveclient python-oslo-messaging python-sphinxcontrib-httpdomain sphinx python-passlib python-pycadf python-fixtures python-dogpile-cache python-dogpile-core python-mock python-oauthlib python-ldap python-webtest

RUN pip install mox

ADD ssh /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/known_hosts
ADD build_bb.sh /usr/bin/

#CMD /usr/bin/build_bb.sh
ENTRYPOINT ["/usr/bin/build_bb.sh"]
 
