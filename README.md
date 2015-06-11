# docker-vault

This repo contains a docker image which runs vault in an "alpha" mode.

One step up from dev.

1) Use a file as backend (not HA capable)

2) Use TLS

3) Run on Alpine

### simple instructions

clone the repo into a directory that you want to work in

run the following command 

```sudo docker build -f /opt/vault/Dockerfile .```


```

sudo docker build -f /opt/vault/Dockerfile .

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
```

After you see something like the above, run this:

```sudo docker images```

find the image ID - in this case it's 6808800d3546 and tag it:

```sudo docker tag 6808800d3546 vaultalpha```

This is the output with the assigned name tageright name on the newly created image

```
REPOSITORY                    TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
docker.io/vaultalpha          latest              6808800d3546        5 minutes ago       22.83 MB
docker.io/ubuntu              14.04               fa81ed084842        9 days ago          188.3 MB
docker.io/alpine              latest              8697b6cc1f48        12 days ago         5.238 MB
docker.io/gliderlabs/alpine   latest              3adc3de69ee5        12 days ago         5.238 MB
```


Then run it with shell and IPC_LOCK (resolves mlock issue):

```sudo docker run -i -t --rm --entrypoint sh --cap-add IPC_LOCK vaultalpha```

