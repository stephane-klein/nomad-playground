job "postgres-example" {
    datacenters = ["dc1"]
    type = "service"

    constraint {
        attribute = "${node.unique.name}"
        value = "myserver1"
    }

    group "postgres" {
        /*volume "postgres_data" {
            type = "host"
            source = "volumetest1"
        }*/
        task "postgres" {
            driver = "docker"
            config {
                image = "postgres:15"
            }
            /*
            volume_mount {
                volume ="postgres_data"
                destination = "/var/lib/postgresql/data/"
                read_only = false
            }
            */
        }
    }
}
