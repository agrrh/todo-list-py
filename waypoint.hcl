project = "todo-list-py"

app "backend" {
  build {
    use "docker" {}
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
    use "docker" {}
  }

  deploy {
    use "kubernetes" {}
  }

  release {
    use "kubernetes" {}
  }
}
