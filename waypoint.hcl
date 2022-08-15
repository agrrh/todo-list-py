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
    }
  }

  deploy {
    use "kubernetes" {}
  }

  release {
    use "kubernetes" {}
  }
}
