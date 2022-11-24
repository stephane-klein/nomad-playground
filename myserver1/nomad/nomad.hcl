# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

advertise {
  http = "192.168.56.5:4646"
  rpc  = "192.168.56.5:4647"
  serf = "192.168.56.5:4648"
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
  servers = ["127.0.0.1"]
}
