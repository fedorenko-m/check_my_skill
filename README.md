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

5. If you need to delete resources:
 
    terraform destroy -auto-approve

## 2. ANSIBLE
## Project structure

<img width="314" height="360" alt="изображение" src="https://github.com/user-attachments/assets/0aa9fcef-0d34-4e1d-80aa-1fe19353d6c2" />


## Requirements:

- Linux environment (Ubuntu/Debian recommended)
- Ansible >= 2.13
- Molecule >= 5
- Docker (for Molecule scenarios)

## Run playbook manually on a local VM
    ansible-playbook -i ansible/inventory/containers.ini ansible/playbooks/site.yml

## Verify:

    systemctl status nginx
    php -v
    ls -l /var/www/html/index.php

## Ansible Lint:

    ansible-lint ansible/roles/web

## If you want to revert changes

    ansible-playbook -i ansible/inventory/containers.ini ansible/playbooks/destroy.yml
