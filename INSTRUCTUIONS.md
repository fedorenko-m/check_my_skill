1. TERRAFORM
Requirements

Docker >= 20.x

Terraform >= 1.4.0

Bash (for ensure_deploy.sh script)

Setup & Initialization
cd terraform
terraform init
terraform fmt
terraform validate
tflint

Create Resources
terraform apply -auto-approve -var "app_env=dev" -var "host_port=8080"


The ensure_deploy.sh script automatically creates the deploy/ directory and basic index.php and nginx.conf files.

The null_resource + script only runs when app_env changes.

Verify Deployment
docker ps
curl http://localhost:8080/
curl http://localhost:8080/healthz


The /healthz endpoint should return 200 OK.

Destroy Resources
terraform destroy -auto-approve

2. ANSIBLE
Requirements

Linux (Ubuntu/Debian recommended)

Ansible >= 2.13

Molecule >= 5

Docker (for Molecule scenarios)

Run Playbook Locally
ansible-playbook -i ansible/inventory/containers.ini ansible/playbooks/site.yml

Verify Installation
systemctl status nginx
php -v
ls -l /var/www/html/index.php
curl http://localhost/healthz


/healthz should respond correctly, indicating the web server and PHP-FPM are working.

Lint Check
ansible-lint ansible/roles/web

Run Molecule Tests
cd ansible/roles/web
molecule test


This will spin up Docker containers and test the role in an isolated environment.

Revert Changes
ansible-playbook -i ansible/inventory/containers.ini ansible/playbooks/destroy.yml


This playbook will remove all changes applied by the web role.
