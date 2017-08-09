### Build
```
docker build -t simpleware/vnc-rdp-ssh:v1 .
```
### Run
```
docker run -d -p 5900:5900 -p 6900:6900 consol/centos-xfce-vnc
```
### test
http://localhost:6900/?password=

