FROM gliderlabs/alpine
MAINTAINER Tim Kropp <timkropp77@gmail.com>
ENV VAULT_VERSION 0.6.0

ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.zip
RUN cd /bin && unzip /tmp/vault.zip && chmod +x /bin/vault && rm /tmp/vault.zip

COPY vaultconfig.hcl /opt/vault/vaultconfig.hcl

EXPOSE 8200
ENV VAULT_ADDR "http://127.0.0.1:8200"

ENTRYPOINT ["/bin/vault"]
CMD ["server"]
