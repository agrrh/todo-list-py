project = "todo-list-py"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/agrrh/todo-list-py.git"
    ref = "hotfix/1660596201"
  }
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
    use "kubernetes" {}
  }

  release {
    use "kubernetes" {}
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
    use "kubernetes" {}
  }

  release {
    use "kubernetes" {}
  }
}

variable "docker_hub_password" {
  type    = string
  default = ""
  env     = ["DOCKER_HUB_PASSWORD"]
}
