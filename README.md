# docker-vault
[![](https://badge.imagelayers.io/sometheycallme/vaultalpha.svg)](https://imagelayers.io/?images=cleanerbot/docker-vault:latest 'View image size and layers')&nbsp;
[![Circle CI](https://circleci.com/gh/cleanerbot/docker-vault.png?circle-token=4f0cb187a0b1ae8937389ecceca8acf3a8122b8e)](https://circleci.com/gh/sometheycallme/docker-vault/tree/master 'View CI builds')

Project URL: https://github.com/cleanerbot/docker-vault
Docker registry: https://registry.hub.docker.com/u/sometheycallme/vaultalpha

This repo contains a docker image which runs vault in an "alpha" mode.

One step up from dev.

1) Use a file as backend (not HA capable)

2) Use TLS

3) Run on Alpine

### Image Pull Instructions

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

This is the output with the assigned name tag to the newly created image

```
REPOSITORY                    TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
docker.io/vaultalpha          latest              6808800d3546        5 minutes ago       22.83 MB
docker.io/ubuntu              14.04               fa81ed084842        9 days ago          188.3 MB
docker.io/alpine              latest              8697b6cc1f48        12 days ago         5.238 MB
docker.io/gliderlabs/alpine   latest              3adc3de69ee5        12 days ago         5.238 MB
```

### Configuration

Once you pull the image, you'll need to run it.   And open another terminal to run docker exec to enter the container and launch vault.

1) Run the container

```sudo docker run -i -t --rm --entrypoint sh --cap-add IPC_LOCK vaultalpha```

In a new terminal window, exec a shell (grab the image that is running from above command).

``` 
docker ps -a

CONTAINER ID        IMAGE                              COMMAND                CREATED             STATUS                    PORTS               NAMES
734e7952e070        sometheycallme/vaultalpha:latest   "sh c"                 11 hours ago        Running         
```

Grab the ID 

```sudo docker exec -it 734e7952e070 sh```

2) Initialize it and grab the keys - you need them to open the vault!

Once you have a separate shell exec'd go ahead and init

```
/ # vault init 
Key 1: 21f086ce697f5b5f8635d07d34b35c9124d043e3654d5df2dbe29f5da4d4979c01
Key 2: be0092d8505d268cb0d25c447d6eaf8afb2d41ab40f6ffe322175dec36acac9102
Key 3: 56ecee66b02c8d4ccf7428e26a84e75477170243cc1f721d0033dc0dba9ede2903
Key 4: e1755c2a285a1daf81490ff344fad54d5585b3e73e5a36e91e2deb0e60caf50004
Key 5: 09992094c82bb66ffeef7b5553109d93d9bff00fb2b3bb173c096aefecf887b805

Initial Root Token: 112f9aa7-352f-a988-76d2-66f08599013e

Vault initialized with 5 keys and a key threshold of 3!
```


3) Unseal the vault with any 3 of 5 keys 3 

```
/ # vault unseal 21f086ce697f5b5f8635d07d34b35c9124d043e3654d5df2dbe29f5da4d4979c01
<snip>
/ # vault unseal 56ecee66b02c8d4ccf7428e26a84e75477170243cc1f721d0033dc0dba9ede2903
<snip>
/ # vault unseal 09992094c82bb66ffeef7b5553109d93d9bff00fb2b3bb173c096aefecf887b805
<snip>
```

4) Authenticate to the vault with root

```
/ # vault auth 112f9aa7-352f-a988-76d2-66f08599013e

Successfully authenticated! The policies that are associated
with this token are listed below:

root
```

5) Finally, test reading and writing secrets

Write it
```
/ # vault write secret/foo password=bar lease=1h
Success! Data written to: secret/foo
```

Read it
```
/ # vault read secret/foo
Key            	Value
lease_id       	secret/foo/37d4cfb7-98c0-e330-eb32-32c916d326ca
lease_duration 	3600
lease_renewable	%!d(string=true)
lease          	1h
password       	bar
/ # 
```
