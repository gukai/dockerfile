### Build
```
docker build -t simpleware/nvidia_cuda_8.0-cudnn6-devel_console:<real_version> -t simpleware/nvidia_cuda_8.0-cudnn6-devel_console:latest .
```
### Run
```
docker run -d -p 22022:22 -p 3389:3389 -p 5900:5900 -p 6900:6900 simpleware/nvidia_cuda_8.0-cudnn6-devel_console:latest
```
### test
http://<host-ip>:6900/?password=vncpassword
ssh <host-ip> 22022; 123456



