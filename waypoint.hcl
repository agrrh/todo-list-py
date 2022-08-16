project = "todo-list-py"

labels = {
  "app" = "todo-list-py"
}

app "backend" {
  build {
    use "docker" {
      context = "backend"
      dockerfile = "backend/Dockerfile"
    }

    registry {
      use "docker" {
        image = "docker.io/agrrh/todo-list-py"
        tag   = "back-${substr(gitrefhash(), 0, 7)}"
        username = "agrrh"
        password = var.docker_hub_password
      }
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "todo-list-py"
      pod {
        container {
          port {
            name = "http"
            port = 3000
          }
        }
      }
    }
  }

  release {
    use "kubernetes" {
      namespace = "todo-list-py"
      load_balancer = false
      port          = 3000
      ingress "http" {
        annotations = {
          "kubernetes.io/ingress.class" = "public"
        }
        host = "todo-back.agrrh.com"
        path = "/"
      }
    }
  }
}

app "frontend" {
  build {
    use "docker" {
      context = "frontend"
      dockerfile = "frontend/Dockerfile"
    }

    registry {
      use "docker" {
        image = "docker.io/agrrh/todo-list-py"
        tag   = "front-${substr(gitrefhash(), 0, 7)}"
        username = "agrrh"
        password = var.docker_hub_password
      }
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "todo-list-py"
      pod {
        container {
          port {
            name = "http"
            port = 80
          }
        }
      }
    }
  }

  release {
    use "kubernetes" {
      namespace = "todo-list-py"
      load_balancer = false
      port          = 80
      ingress "http" {
        annotations = {
          "kubernetes.io/ingress.class" = "public"
        }
        host = "todo.agrrh.com"
        path = "/"
      }
    }
  }
}

app "redis" {
  build {
    use "docker-pull" {
      image = "redis"
      tag   = "7"
    }
  }

  deploy {
    use "kubernetes-apply" {
      path = templatedir("${path.app}/kubernetes/redis")
      prune_label = "app-part=redis"
    }
  }
}


variable "docker_hub_password" {
  type    = string
  default = ""
  env     = ["DOCKER_HUB_PASSWORD"]
}
