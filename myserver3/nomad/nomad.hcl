# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  enabled          = false
}

client {
  enabled = true
  servers = ["127.0.0.1"]

  server_join {
    retry_join = ["myserver1:4648"]
  }
}
