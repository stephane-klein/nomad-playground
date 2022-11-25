job "http-echo-hello" {
    datacenters = ["dc1"]
    type = "service"

    constraint {
        attribute = "${node.unique.name}"
        value = "myserver1"
    }

    group "http-echo" {
        network {
            port "http" {
                static = "5678"
                host_network = "public"
            }
        }

        task "http-echo" {
            driver = "docker"
            config {
                image = "hashicorp/http-echo"
                args  = ["-text", "hello world"]
                ports = ["http"]
            }
        }
    }
}
