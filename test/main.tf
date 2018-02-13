module "service" {
  source = ".."

  name  = "myredis"
  image = "redis:3.2"

  instances = 1
  net       = "host"
  user      = "app"
}
