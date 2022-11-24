# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

advertise {
  http = "192.168.56.11:4646"
  rpc  = "192.168.56.11:4647"
  serf = "192.168.56.11:4648"
}

server {
  enabled          = false
}

client {
  enabled = true

  server_join {
    retry_join = [
        "myserver1",
        "myserver2"
    ]
    retry_max = 3
    retry_interval = "15s"
  }
}
