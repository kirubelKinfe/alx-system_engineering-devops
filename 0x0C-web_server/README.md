# 0x0C-web_server

This directory contains scripts for configuring and managing web servers as part of the ALX System Engineering DevOps curriculum. The tasks focus on setting up Nginx, configuring domain names, and handling file transfers on Ubuntu servers.

## Requirements
- All scripts are designed for a new Ubuntu machine, referred to as `web-01`.
- Scripts must be executed with root privileges unless specified otherwise.
- Nginx is used as the web server and must listen on port 80.
- Configurations are tested using tools like `curl`, `dig`, and `ssh`.

## Files

### 0-transfer_file
- **Purpose**: Transfers a file to a server’s user home directory using `scp`.
- **Details**:
  - Accepts 4 parameters: file path, server IP, username, and SSH private key path.
  - Disables strict host key checking for `scp`.
  - Displays usage message if fewer than 4 parameters are provided.
- **Usage**:
  ```bash
  ./0-transfer_file some_page.html 34.198.248.145 sylvain /vagrant/private_key
  ```
- **Verification**:
  - Check the server’s home directory before and after:
    ```bash
    ssh -i /vagrant/private_key sylvain@34.198.248.145 'ls ~/'
    ```
    Expected output after transfer: `some_page.html` added to the list.

### 1-install_nginx_web_server
- **Purpose**: Installs and configures Nginx to serve a "Hello World!" page on port 80.
- **Details**:
  - Installs Nginx using `apt-get` with `-y` flag.
  - Creates `/var/www/html/index.html` with "Hello World!".
  - Configures Nginx to serve the page at the root (`/`).
  - Uses `service nginx reload` to avoid `systemctl`.
- **Usage**:
  ```bash
  sudo ./1-install_nginx_web_server > /dev/null 2>&1
  ```
- **Verification**:
  - Locally: `curl localhost` (Expected: `Hello World!`)
  - Remotely: `curl 34.198.248.145` (Expected: `Hello World!`)

### 2-setup_a_domain_name
- **Purpose**: Registers a .tech domain and configures its DNS to point to `web-01`.
- **Details**:
  - Uses the GitHub Student Developer Pack to register a free .tech domain via .TECH Domains (registrar: Dotserve Inc).
  - Configures an A record to point to `web-01`’s IP (e.g., `34.198.248.145`).
  - Updates the GitHub profile with the domain (e.g., `myschool.tech`).
- **Verification**:
  - Check DNS: `dig myschool.tech` (Expected: A record with `34.198.248.145`).
  - Verify registrar: Use `https://whois.whoisxmlapi.com/` to confirm `"registrarName": "Dotserve Inc"`.
  - Access: `curl myschool.tech` (Expected: `Hello World!` if Nginx is configured).

### 3-redirection
- **Purpose**: Configures Nginx with a 301 redirect for `/redirect_me`.
- **Details**:
  - Installs Nginx and sets up a "Hello World!" page.
  - Adds a `location /redirect_me` block to redirect to `https://www.youtube.com/watch?v=QH2-TGUlwu4` with a 301 status.
  - Uses `service nginx reload`.
- **Usage**:
  ```bash
  sudo ./3-redirection > /dev/null 2>&1
  ```
- **Verification**:
  - Check redirect: `curl -sI 34.198.248.145/redirect_me/` (Expected: `HTTP/1.1 301 Moved Permanently`, `Location: https://www.youtube.com/watch?v=QH2-TGUlwu4`).
  - Check root: `curl 34.198.248.145` (Expected: `Hello World!`).

### 4-not_found_page_404
- **Purpose**: Configures Nginx with a custom 404 page.
- **Details**:
  - Installs Nginx, sets up a "Hello World!" page, and adds the `/redirect_me` redirect.
  - Creates `/var/www/html/404.html` with "Ceci n'est pas une page".
  - Configures `error_page 404 /404.html` to return a 404 status.
- **Usage**:
  ```bash
  sudo ./4-not_found_page_404 > /dev/null 2>&1
  ```
- **Verification**:
  - Check 404: `curl -sI 34.198.248.145/xyz` (Expected: `HTTP/1.1 404 Not Found`).
  - Check 404 page: `curl 34.198.248.145/xyz` (Expected: `Ceci n'est pas une page`).

### 7-puppet_install_nginx_web_server.pp
- **Purpose**: Configures Nginx using Puppet instead of Bash.
- **Details**:
  - Installs Nginx, creates a "Hello World!" page, and sets up the `/redirect_me` 301 redirect.
  - Uses Puppet resources (`package`, `file`, `service`) to manage the configuration.
- **Usage**:
  ```bash
  sudo puppet apply 7-puppet_install_nginx_web_server.pp
  ```
- **Verification**:
  - Same as `3-redirection`: Check root page and redirect with `curl`.

## Troubleshooting
- **Nginx Issues**: Check logs in `/var/log/nginx/error.log` or `/var/log/nginx/access.log`.
- **Port 80 Blocked**: Ensure no other service uses port 80 (`sudo netstat -tuln | grep 80`) and the firewall allows it (`sudo ufw allow 80`).
- **DNS Propagation**: Wait 1-2 hours for DNS changes; use `dig` to verify.
- **File Permissions**: Ensure Nginx can read `/var/www/html/` (`sudo chmod -R 755 /var/www/html`).
- **Puppet Errors**: Verify Puppet is installed (`sudo apt-get install puppet`) and the manifest syntax is correct.

## Repository
- **GitHub Repository**: [alx-system_engineering-devops](https://github.com/alx-system_engineering-devops)
- **Directory**: 0x0C-web_server