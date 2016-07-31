##### 现状
1. docker hub 中的 debian已经被移除，可以通过 [Debian说明页](https://hub.docker.com/r/library/debian/)，找到老的创建页面。
2. 创建页面指向的GIT hub 中的信息也被移除，需要自己通过branch找回老的内容。
3. 暂时不清楚debian为何清理相关内容

**此页面中其他文件都是范例文件，缺少部分文件，无法直接使用**

##### 当前自己创建方法
yum install https://github.com/tianon/docker-brew-debian.git
cd docker-brew-debian/jessie/Dockerfile
docker build -t debian:latest .
