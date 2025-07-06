# 0x13-firewall

This directory contains scripts for configuring the `ufw` firewall on an Ubuntu server (`web-01`) as part of the ALX System Engineering DevOps curriculum. The tasks focus on setting up firewall rules to control incoming traffic and configure port forwarding.

## Requirements
- All scripts are designed for a new Ubuntu machine.
- The server is referred to as `web-01`.
- Scripts must be executed with root privileges.
- The `ufw` firewall is used for configuration.
- Configurations are tested using tools like `curl` and `netstat`.

## Files

### 0-block_all_incoming_traffic_but
- **Purpose**: Configures `ufw` to block all incoming traffic except TCP ports 22 (SSH), 80 (HTTP), and 443 (HTTPS).
- **Details**:
  - Installs `ufw` if not already installed.
  - Sets default policies: deny all incoming traffic, allow all outgoing traffic.
  - Explicitly allows TCP ports 22, 80, and 443.
  - Enables the firewall without prompting.
- **Usage**:
  ```bash
  sudo ./0-block_all_incoming_traffic_but
  ```
- **Verification**:
  - Check firewall status:
    ```bash
    sudo ufw status
    ```
    Expected output:
    ```
    Status: active
    To                         Action      From
    --                         ------      ----
    22/tcp                     ALLOW       Anywhere
    80/tcp                     ALLOW       Anywhere
    443/tcp                    ALLOW       Anywhere
    22/tcp (v6)                ALLOW       Anywhere (v6)
    80/tcp (v6)                ALLOW       Anywhere (v6)
    443/tcp (v6)               ALLOW       Anywhere (v6)
    ```
  - Test connectivity to allowed ports (e.g., `curl http://<web-01-ip>`).
  - Test blocked ports (e.g., `curl http://<web-01-ip>:8080` should fail).

### 100-port_forwarding
- **Purpose**: Configures `ufw` to forward incoming traffic from port 8080/TCP to port 80/TCP, while maintaining the rules from `0-block_all_incoming_traffic_but`.
- **Details**:
  - Installs `ufw` if not already installed.
  - Sets default policies: deny all incoming traffic, allow all outgoing traffic.
  - Allows TCP ports 22, 80, 443, and 8080.
  - Adds NAT rules to `/etc/ufw/before.rules` to redirect port 8080/TCP to port 80/TCP.
  - Outputs the modified `/etc/ufw/before.rules` file.
- **Usage**:
  ```bash
  sudo ./100-port_forwarding
  ```
- **Verification**:
  - Check firewall status:
    ```bash
    sudo ufw status
    ```
    Expected output includes allowed ports (22, 80, 443, 8080).
  - Verify Nginx is listening on port 80:
    ```bash
    netstat -lpn | grep nginx
    ```
  - Test port forwarding from another machine (e.g., `web-02`):
    ```bash
    curl -sI <web-01-ip>:80
    curl -sI <web-01-ip>:8080
    ```
    Both should return `HTTP/1.1 200 OK` (assuming Nginx serves a page like `Hello World!`).
  - Check the response body:
    ```bash
    curl <web-01-ip>:8080
    ```
    Expected output: `Hello World!` (or the content served by Nginx on port 80).

## Troubleshooting
- **UFW Not Installed**: Ensure `apt-get install ufw -y` succeeds. Check `/var/log/apt/` for errors.
- **SSH Lockout**: Always verify port 22 is allowed before enabling `ufw`. Use a cloud provider’s console to recover if locked out.
- **Port Forwarding Issues**: Confirm `/etc/ufw/before.rules` contains the NAT rules and that Nginx is listening on port 80.
- **Connection Refused**: Ensure no other services block ports 80 or 8080 (`netstat -tuln`) and that the firewall is active.
- **Logs**: Check `/var/log/ufw.log` for firewall-related issues.

## Repository
- **GitHub Repository**: [alx-system_engineering-devops](https://github.com/alx-system_engineering-devops)
- **Directory**: 0x13-firewall

## Notes
- These scripts assume Nginx is configured on `web-01` to serve content on port 80 (e.g., from previous tasks like `0x0C-web_server`).
- The configurations can optionally be applied to `lb-01` and `web-02`, but only `web-01` is required for evaluation.
- Always test firewall changes in a controlled environment to avoid accidental lockouts.