job "demo-webapp2" {
  datacenters = ["dc1"]
  group "example" {
    network {
      port "redis" { to = 6379 }
    }
    task "example" {
      driver = "docker"

      config {
        image = "redis"
        ports = ["redis"]
      }
    }
    service {
      name = "demo-webapp2"
      port = "redis"

      check {
        port     = "redis"
        type     = "tcp"
        interval = "2s"
        timeout  = "2s"
      }
    }
  }
}