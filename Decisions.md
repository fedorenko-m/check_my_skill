## Why you chose these variables and default values.

web_root — standard directory for web content on Ubuntu/Debian.
web_packages — minimal set for a web server with PHP. Default packages ensure compatibility with most Linux distributions.
user — standard user for Nginx to ensure file permissions are secure.
Socket for PHP-FPM — Unix socket is chosen instead of TCP because it is faster and more secure for local interaction between Nginx and PHP-FPM (does not open a port to the network

## How you connected Nginx and PHP-FPM (socket vs TCP), why

PHP-FPM is connected via a Unix socket in the nginx.conf.j2 template.
Unix socket is faster for local connections. It does not open a TCP port, reducing the risk of network access. Less configuration and dependencies (no need to manage ports). 
If TCP were used, it would be more flexible for distributed systems, but locally, socket is better.

## How you ensured idempotency in Ansible

In Ansible, this is achieved through:
Modules that provide idempotency: ansible.builtin.apt, ansible.builtin.user, ansible.builtin.file, ansible.builtin.template.

For example, apt will only install packages if they are missing.
file will only create a directory if it does not exist.
template will only replace a file if its content has changed.
.j2 templates are used without hardcoded values.
Handlers: notify: Restart nginx will only work if the configuration has changed.

## What exactly /healthz checks and how

Checks that Nginx is running and can serve requests.
You can add a check for PHP-FPM availability if needed.
Used for monitoring.

## What you would improve given more time
Automatic certificate generation (Let's Encrypt) via Ansible.
Automated tests for /healthz
Logging & monitoring integration
Backend for tfstate
