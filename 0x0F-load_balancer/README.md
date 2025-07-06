# 0x0F-load_balancer

This directory contains a Puppet manifest for configuring an Nginx web server with a custom HTTP header on an Ubuntu machine, as part of the ALX System Engineering DevOps curriculum. The task focuses on adding a load balancer-related configuration to include the server’s hostname in responses.

## Requirements
- The script is designed for a new Ubuntu machine (`web-01`).
- Must be executed with root privileges.
- Nginx must listen on port 80 and serve a "Hello World!" page.
- A custom HTTP header `X-Served-By` must contain the server’s hostname.

## Files

### 2-puppet_custom_http_response_header.pp
- **Purpose**: Configures Nginx using Puppet to include a custom `X-Served-By` header with the server’s hostname.
- **Details**:
  - Installs Nginx using the `package` resource.
  - Creates `/var/www/html/index.html` with "Hello World!".
  - Configures `/etc/nginx/sites-available/default` to serve the page and add the `X-Served-By: <hostname>` header.
  - Uses Puppet’s `facts['networking']['hostname']` to dynamically get the hostname.
  - Ensures the Nginx service is running and reloads it without `systemctl`.
- **Usage**:
  ```bash
  sudo puppet apply 2-puppet_custom_http_response_header.pp
  ```
- **Verification**:
  - Check root page: `curl 34.198.248.145` (Expected: `Hello World!`).
  - Check headers: `curl -sI 34.198.248.145` (Expected: `X-Served-By: <hostname>`, e.g., `X-Served-By: web-01`).
  - Locally: `curl localhost` and `curl -sI localhost`.

## Troubleshooting
- **Puppet Not Installed**: Install with `sudo apt-get install puppet`.
- **Header Missing**: Verify `add_header X-Served-By` in `/etc/nginx/sites-available/default`.
- **Nginx Issues**: Check logs in `/var/log/nginx/error.log` or `/var/log/nginx/access.log`.
- **Port 80 Blocked**: Ensure no other service uses port 80 (`sudo netstat -tuln | grep 80`) and the firewall allows it (`sudo ufw allow 80`).
- **File Permissions**: Ensure `/var/www/html/` is readable (`sudo chmod -R 755 /var/www/html`).

## Repository
- **GitHub Repository**: [alx-system_engineering-devops](https://github.com/alx-system_engineering-devops)
- **Directory**: 0x0F-load_balancer