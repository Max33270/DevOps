# DevOps

![Final Result](https://github.com/Max33270/DevOps/blob/main/kube_result.png)

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

## IV. Usage with Kubernetes
```bash
kubectl apply -f kube.yaml
kubectl apply -f ingress.yaml
kubectl apply -f service.yaml
# Install Ingress (only if you're not on Linux)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml
```

```bash
$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
kube-one                      1/1     Running   0          3m39s
kube-two-wwgtx                1/1     Running   0          2s
kube-two-gdrb8                1/1     Running   0          2s
kube-three-8647d76f6b-m45bs   1/1     Running   0          2s
kube-three-8647d76f6b-gl4nj   1/1     Running   0          2s
kube-two-xjb28                1/1     Running   0          2s
kube-three-8647d76f6b-58dqr   1/1     Running   0          2s
kube-two-h7962                1/1     Running   0          2s
kube-three-8647d76f6b-d2q6x   1/1     Running   0          2s
```
```bash
$ kubectl get services
NAME         TYPE           CLUSTER-IP        EXTERNAL-IP   PORT(S)        AGE
service-1    LoadBalancer   XXX.XXX.XXX.XXX   <pending>     80:30938/TCP   16m
kubernetes   ClusterIP      XXX.XXX.XXX.XXX   <none>        443/TCP        11m
```
```bash
$ kubectl get deployment          
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
kube-three   0/0     0            0           17m
```
```bash
$ kubectl get ingress                     
NAME          CLASS   HOSTS            ADDRESS        PORTS   AGE
ingress-one   nginx   kubernetes.max   198.19.249.2   80      2d1h
```

## Extra Useful Commands
```bash
# Docker
docker exec -it <container_id> /bin/bash
docker system prune
docker stop <container>
sudo docker-compose down
docker-compose rm
# Kubernetes 
kubectl logs <pod_name>
kubectl delete pod <pod_name>
kubectl delete service <service_name>
kubectl delete deployment <deployment_name>
```