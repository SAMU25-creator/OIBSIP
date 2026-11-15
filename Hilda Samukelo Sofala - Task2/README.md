# OIBSIP Task 2: Configure Firewall Using UFW

## 1. Overview
This project configures a firewall using Uncomplicated Firewall (UFW) on Ubuntu Linux.

The purpose is to control incoming network traffic by allowing or blocking specific ports.

## 2. Firewall Rules

| Port | Protocol | Action | Purpose |
|------|----------|--------|---------|
| 22 | TCP | Allow | SSH |
| 80 | TCP | Deny | HTTP |
| 443 | TCP | Allow | HTTPS |
| 21 | TCP | Deny | FTP |

The firewall uses these default policies:
- Incoming traffic: Deny
- Outgoing traffic: Allow
- Routed traffic: Deny

The rules apply to IPv4 and IPv6.

## 3. Automation Script

The `ufw_configuration.sh` script automates the firewall setup.

To run it:

```bash
chmod +x ufw_configuration.sh
sudo ./ufw_configuration.sh

## 4. Testing
The firewall was tested using a temporary Python HTTP server and PowerShell's Test-NetConnection command.

Two tests were performed on port 80:
- When port 80 was allowed, TcpTestSucceeded returned True.
- When port 80 was denied, TcpTestSucceeded returned False.
This comparison demonstrated that the connection was permitted when the allow rule was active and blocked when the deny rule was active.

## 5. Evidence
The screenshots folder contains:
- ufw_status.png – UFW firewall status and rules.
- http_allowed_test.png – Successful connection when HTTP was allowed.
- http_blocked_test.png – Failed connection when HTTP was denied.

## 6. Environment
- Operating System: Ubuntu Linux on WSL
- Firewall: UFW
- Testing platform: Windows PowerShell
- Script language: Bash
