### Build
```
$ docker build -t rdp:latest .
```
### Run
```
$ docker run -dp 3389:3389 --restart=always rdp:latest
```

