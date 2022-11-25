job "http-echo-hello" {
    datacenters = ["dc1"]
    type = "service"

    group "http-echo" {
        network {
            port "http" {
                static = "5678"
            }
        }

        task "http-echo" {
            driver = "docker"
            config {
                image = "hashicorp/http-echo"
                args  = ["-text", "hello world"]
            }
        }
    }
}
