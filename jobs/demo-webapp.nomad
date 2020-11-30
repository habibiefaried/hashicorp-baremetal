job "demo-webapp" {
  datacenters = ["dc1"]

  group "demo" {
    count = 1

    task "server" {
      driver = "docker"

      config {
        image = "mendhak/http-https-echo"
        port_map {
          demowebapp = 80
        }
        dns_servers = ["172.17.0.1"]
      }

      resources {
        network {
          port "demowebapp" {}
        }
      }

      service {
        name = "demo-webapp"
        port = "demowebapp"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.demowebapp.rule=Host(`demo-webapp.nomad.habibiefaried.com`)",
          "traefik.http.routers.demowebapp.tls=true",
          "traefik.http.routers.demowebapp.tls.certresolver=myresolver",
          "traefik.http.routers.demowebapp.entrypoints=http,websecure",
          "traefik.http.routers.demowebapp.tls.domains[0].main=demo-webapp.nomad.habibiefaried.com",
        ]

        check {
          type     = "http"
          path     = "/"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}