# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  enabled          = false
}

client {
  enabled = true

  server_join {
    retry_join = [
        "myserver1",
        "myserver3"
    ]
    retry_max = 3
    retry_interval = "15s"
  }
}
