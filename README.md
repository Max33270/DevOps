# TP DevOps

## I. Installation du projet 

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

## II. Utilisation de la solution

```bash
cd DevOps
echo PING_LISTEN_PORT=7878 > .env
export PING_LISTEN_PORT=7878 && cargo run
curl localhost:7878/ping -v
```

Expected result : 
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