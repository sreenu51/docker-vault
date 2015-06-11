FROM gliderlabs/alpine
MAINTAINER Tim Kropp <timkropp77@gmail.com>


ADD https://dl.bintray.com/mitchellh/vault/vault_0.1.1_linux_amd64.zip /tmp/vault.zip
RUN cd /bin && unzip /tmp/vault.zip && chmod +x /bin/vault && rm /tmp/vault.zip

COPY vaultconfig.hcl /opt/vault/vaultconfig.hcl

EXPOSE 8200
ENV VAULT_ADDR "http://127.0.0.1:8200"

ENTRYPOINT ["/bin/vault"]
CMD ["server"]
