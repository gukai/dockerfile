### Build
```
docker build -t nvidia/cuda:8.0-cudnn7-devel-console .
```
### Run
```
docker run -d -p 22022:22 -p 3389:3389 -p 5900:5900 -p 6900:6900 nvidia/cuda:8.0-cudnn7-devel-console
```
### test
http://<host-ip>:6900/?password=vncpassword
ssh <host-ip> 22022; 123456



