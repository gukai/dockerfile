### Build
```
docker build -t simpleware/vnc-rdp-ssh:v1 -t simpleware/vnc-rdp-ssh:latest .
```
### Run
```
docker run -d -p 22022:22 -p 3389:3389 -p 5900:5900 -p 6900:6900 simpleware/centos-xfce-vnc
```
### test
http://<host-ip>:6900/?password=vncpassword
ssh <host-ip> 22022; 123456



