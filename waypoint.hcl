project = "todo-list-py"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/agrrh/todo-list-py.git"
    ref = "hotfix/1660596201"
  }
}

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
        host = "back.agrrh.tech"
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
        host = "front.agrrh.tech"
        path = "/"
      }
    }
  }
}

variable "docker_hub_password" {
  type    = string
  default = ""
  env     = ["DOCKER_HUB_PASSWORD"]
}
