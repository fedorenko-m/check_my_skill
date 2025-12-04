## Ansible CI
<img width="1524" height="827" alt="изображение" src="https://github.com/user-attachments/assets/c13026a0-58d3-4a79-94fe-e105fb02e9a6" />
## Terraform CI
<img width="1520" height="772" alt="изображение" src="https://github.com/user-attachments/assets/76155198-5040-4901-afdb-d27e33892b39" />


## 1.TERRAFORM
## Project structure

    terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── provider.tf
    ├── scripts/
    │   └── ensure_deploy.sh
    deploy/     #automatically created by the script


## Requirements:

 - Docker (>=20.x) installed and running
 - Terraform (>=1.4.0) installed
 - Bash (for the ensure_deploy.sh script)

## Start 

1. Commands for initialization:

    cd terraform
    terraform init
    terraform fmt
    terraform validate
    tflint

2. Creating resources:

    terraform apply -auto-approve -var "app_env=dev" -var "host_port=8080"

# The ensure_deploy.sh script will create deploy/ and the basic index.php and nginx.conf files.
# null_resource + script are executed only when app_env changes.

3. Then you can check docker containers and helthcheck:

    docker ps
    curl http://localhost:8080/
    curl http://localhost:8080/healthz

4. If you need to delete resources:
 
    terraform destroy -auto-approve

## 2. ANSIBLE
## Project structure

ansible/
├── inventory/
│   └── containers.ini      # Inventory for local deployment
├── playbooks/
│   └── site.yml            # Main playbook to deploy web role
│   └── destroy.yml         # Playbook to stop services and clean up
├── roles/
│   └── web/
│       ├── defaults/
│       │   └── main.yml   # Default variables (app_env, paths, container names)
│       ├── handlers/
│       │   └── main.yml   # Handlers for restarting services
│       ├── tasks/
│       │   └── main.yml   # Main tasks: deploy Nginx, PHP-FPM, logrotate
│       └── templates/
│           ├── index.php.j2
│           └── nginx.conf.j2


ansible/
├── inventory/
│   └── containers.ini      # Inventory for local deployment
├── playbooks/
│   └── site.yml            # Main playbook to deploy web role
│   └── destroy.yml         # Playbook to stop services and clean up
├── roles/
│   └── web/
│       ├── defaults/
│       │   └── main.yml   # Default variables (app_env, paths, container names)
│       ├── handlers/
│       │   └── main.yml   # Handlers for restarting services
│       ├── tasks/
│       │   └── main.yml   # Main tasks: deploy Nginx, PHP-FPM, logrotate
│       └── templates/
│           ├── index.php.j2
│           └── nginx.conf.j2
