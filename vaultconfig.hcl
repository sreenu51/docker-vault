backend "file" {
  path = "/opt/vault/vault-data"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 0
}

