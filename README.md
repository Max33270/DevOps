# DevOps

## I. Install

### 1. MacOs
```bash
brew install rust
git clone "https://github.com/Max33270/DevOps"
```

### 2. Linux 
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
git clone "https://github.com/Max33270/DevOps"
```

## II. Usage

```bash
cd DevOps
echo PING_LISTEN_PORT=7878 > .env
export PING_LISTEN_PORT=7878 && cargo run
curl localhost:7878/ping -v
```

## III. Usage with Docker

### 1) Build
```bash
cd DevOps
sudo docker build -f first.Dockerfile -t single_devops:latest .
sudo docker build -f second.Dockerfile -t multi_devops:latest .
```

### 2) Run Dockerfile(s)
```bash
docker run -e PING_LISTEN_PORT=7878 -it -p 7878:7878 single_devops
docker run -e PING_LISTEN_PORT=7878 -it -p 7878:7878 multi_devops
```

### 3) Run with docker-compose 
```bash
sudo docker-compose up --build
```

### 4) Security Scan
```bash
docker scout cves single_devops > dockerfile1_scan.md
```

Expected Result : 
```bash
*   Trying 127.0.0.1:7878...
* Connected to localhost (127.0.0.1) port 7878 (#0)
> GET /ping HTTP/1.1
> Host: localhost:7878
> User-Agent: curl/8.1.2
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Type: application/json
* no chunk, no close, no size. Assume close to signal end
< 
* Closing connection 0
{"Accept": "*/*", "User-Agent": "curl/8.1.2", "Host": "localhost:7878"}%   
```

Expected Result with Reverse Proxy : 
```bash
devops-proxy-1   | /docker-entrypoint.sh: Configuration complete; ready for start up
devops-my_app-3  | Hostname: "<hostname>"
devops-proxy-1   | X.X.X.X - - [dd/MM/YYYY:hh:dd:ss +0000] "GET /ping HTTP/1.1" 200 851 "-"
devops-proxy-1   | X.X.X.X - - [dd/MM/YYYY:hh:dd:ss +0000] "GET /ping HTTP/1.1" 200 851 "-"
devops-my_app-2  | Hostname: "<hostname>"
```

## Extra Useful Commands
```
docker exec -it <container_id> /bin/bash
docker system prune
docker stop <container>
sudo docker-compose down
docker-compose rm
```