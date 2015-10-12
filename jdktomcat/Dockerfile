#JRE and Tomcat layer for nova Docker
#version 0.2
From oslayer:v0.3
MAINTAINER wangyanyan wangyanyan@syswin.com

# jdk
ADD tar/jdk1.7.0_60.tar.gz /usr/local
ENV JAVA_HOME=/usr/local/jdk1.7.0_60
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


# tomcat
ADD tar/java.tar.gz /home
RUN mkdir /home/webapp && chown -R java.java /home/java /home/webapp && chmod -R 755 /home/java /home/webapp



