output "php_fpm_container_name" {
  value = docker_container.php_fpm.name
}


output "nginx_container_name" {
  value = docker_container.nginx.name
}


output "healthz_url" {
  value = "http://localhost:${var.host_port}/healthz"
}