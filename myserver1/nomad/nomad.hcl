# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

datacenter = "dc1"

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

advertise {
  http = "192.168.56.9:4646"
  rpc  = "192.168.56.9:4647"
  serf = "192.168.56.9:4648"
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true

  host_network "public" {
      interface = "enp0s8"
  }
}
