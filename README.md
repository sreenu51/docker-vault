# docker-vault

This repo contains a docker image which runs vault in an "alpha" mode.

One step up from dev.

1) Use a file as backend (not HA capable)

2) Use TLS

3) Run on Alpine

```
timkropp@localhost vault]$ sudo docker build -f /opt/vault/Dockerfile .
Sending build context to Docker daemon 3.584 kB
Sending build context to Docker daemon 
Step 0 : FROM gliderlabs/alpine
 ---> 3adc3de69ee5
Step 1 : MAINTAINER Tim Kropp <timkropp77@gmail.com>
 ---> Using cache
 ---> ab2b6c30064b
Step 2 : COPY vaultconfig.hcl /opt/vault/vaultconfig.hcl
 ---> Using cache
 ---> adeac3fa83f3
Step 3 : ADD https://dl.bintray.com/mitchellh/vault/vault_0.1.1_linux_amd64.zip /tmp/vault.zip
Downloading 3.615 MB/3.615 MB
 ---> Using cache
 ---> 22a9114c6c12
Step 4 : RUN cd /bin && unzip /tmp/vault.zip && chmod +x /bin/vault && rm /tmp/vault.zip
 ---> Using cache
 ---> 94eacd9fd6d7
Step 5 : EXPOSE 8200
 ---> Running in 2ae65c88b944
 ---> 8f544ab4b5b7
Removing intermediate container 2ae65c88b944
Step 6 : ENV VAULT_ADDR "http://127.0.0.1:8200"
 ---> Running in 402c3cadb4c0
 ---> e4139f8c033c
Removing intermediate container 402c3cadb4c0
Step 7 : ENTRYPOINT /bin/vault server
 ---> Running in 9325c2f7c4a9
 ---> 6808800d3546
Removing intermediate container 9325c2f7c4a9
Successfully built 6808800d3546
[timkropp@localhost vault]$ 
```

