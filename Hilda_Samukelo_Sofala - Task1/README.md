# Task 1: Network Scanning Using Nmap

## Objective
Use Nmap to scan my own computer, identify open TCP ports, detect services, and attempt operating system identification.

## Tools Used
- Nmap 7.992
- Windows PowerShell
- Windows 11

## Target
- IP address: `192.168.43.122`
- Scope: My own computer only

## Methodology

### 1. Basic Port Scan
Command:
```bash
nmap 192.168.43.122
```

The scan found three open TCP ports: 135, 139, and 445. The other 997 scanned TCP ports were closed.

### 2. Service Detection
Command:
```bash
nmap -sV 192.168.43.122
```

Nmap identified Windows RPC on port 135 and Windows NetBIOS session service on port 139. Port 445 was identified as Microsoft-DS, but the exact service version was not confirmed.

### 3. Operating System Detection
Command:
```bash
nmap -O 192.168.43.122
```

Nmap estimated the operating system as Microsoft Windows 11, with details indicating versions 24H2–25H2. This is an estimate, not definitive confirmation of the exact Windows build.

## Findings and Security Analysis

- **Port 135 — MSRPC:** Used for Windows Remote Procedure Call functionality.
- **Port 139 — NetBIOS session service:** Associated with legacy Windows networking and file-sharing functions.
- **Port 445 — Microsoft-DS / commonly SMB:** Commonly associated with Windows file sharing.

Open ports are not automatically vulnerabilities. Their risk depends on the services running, system configuration, firewall rules, patch status, and whether the computer is exposed to untrusted networks.

## Recommendations

1. Keep Windows and security updates current.
2. Ensure Windows Defender Firewall is enabled.
3. Review file-sharing and network-discovery settings.
4. Restrict unnecessary access to ports 135, 139, and 445.
5. Disable services or sharing features only when they are not needed.
6. Repeat the scan after approved changes to verify the results.

## Conclusion

Nmap identified three open TCP ports and estimated the operating system as Windows 11. The scan demonstrates how network scanning can identify services that may need further security review. Additional checks are required to determine whether any actual vulnerability exists.

## Evidence
- `nmap_scan_results.txt` — saved scan output.
- Screenshots of the basic port scan, service detection, and OS detection.
