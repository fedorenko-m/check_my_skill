locals {
  deploy_dir = abspath("${path.module}/deploy")
}

resource "docker_network" "app_net" {
  name = "${var.project_name}-net"
}

resource "docker_image" "php_fpm" {
  name = "php:8.1-fpm-alpine"
}

resource "docker_image" "nginx" {
  name = "nginx:stable-alpine"
}

# Creates deploy/ directory + index.php + nginx.conf
resource "null_resource" "ensure_deploy" {
  triggers = {
    app_env = var.app_env
  }

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/ensure_deploy.sh ${var.app_env}"
  }
}

resource "docker_container" "php_fpm" {
  name  = "${var.project_name}-php-fpm"
  image = docker_image.php_fpm.name

  restart = "unless-stopped"

  networks_advanced {
    name    = docker_network.app_net.name
    aliases = ["php-fpm"]
  }

  volumes {
    host_path      = local.deploy_dir
    container_path = "/var/www/html"
  }
}

resource "docker_container" "nginx" {
  name  = "${var.project_name}-nginx"
  image = docker_image.nginx.name

  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.host_port
  }

  networks_advanced {
    name    = docker_network.app_net.name
    aliases = ["nginx"]
  }

  volumes {
    host_path      = "${local.deploy_dir}/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
    read_only      = true
  }

  volumes {
    host_path      = local.deploy_dir
    container_path = "/var/www/html"
    read_only      = true
  }

  depends_on = [
    null_resource.ensure_deploy,
    docker_container.php_fpm
  ]
}