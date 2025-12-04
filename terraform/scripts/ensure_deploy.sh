#!/usr/bin/env bash
set -e


APP_ENV="$1"
DEPLOY_DIR="$(dirname "$0")/../deploy"


mkdir -p "$DEPLOY_DIR"


# index.php
if [ ! -f "$DEPLOY_DIR/index.php" ]; then
cat > "$DEPLOY_DIR/index.php" << 'PHP'
<?php
echo "Hello from placeholder index.php
";
PHP
fi


# nginx.conf
if [ ! -f "$DEPLOY_DIR/nginx.conf" ]; then
cat > "$DEPLOY_DIR/nginx.conf" << NGINX
server {
listen 80;
server_name _;


root /var/www/html;
index index.php index.html;


location /healthz {
default_type application/json;
return 200 '{"status":"ok","service":"nginx","env":"${APP_ENV}"}';
}


location / {
try_files \$uri \$uri/ /index.php?\$query_string;
}


location ~ \.php$ {
fastcgi_pass php-fpm:9000;
fastcgi_index index.php;
include fastcgi_params;
fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
}
}
NGINX
fi