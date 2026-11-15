# Task 7: Vulnerability Scanning with Nikto

## Objective
Use Nikto to scan the locally hosted Damn Vulnerable Web Application (DVWA), identify potential web server security issues, and document recommended fixes.

## Tools Used
- Nikto 2.1.5
- Kali/Ubuntu WSL
- XAMPP Apache
- Damn Vulnerable Web Application (DVWA)
- curl

## Installation
Nikto was installed using:

sudo apt update
sudo apt install nikto -y

Version checked using:

nikto -Version

## Target
The target was a local DVWA installation hosted by Apache through XAMPP.

Target address used from WSL: 172.21.16.1
Application path: /dvwa

Only the local test application was scanned.

## HTTP Scan

Command:

nikto -h 172.21.16.1 -port 80 -root /dvwa -nossl -output nikto_scan_results.txt

Results:
- 6,544 items checked.
- 19 items reported.
- No scan errors.

## HTTPS Scan

HTTPS availability was verified using:

curl -kI https://172.21.16.1/dvwa/

The server returned HTTP 302 Found, confirming that HTTPS was available.

Nikto command:

nikto -h 172.21.16.1 -port 443 -root /dvwa -ssl -output nikto_ssl_scan_results.txt

Results:
- 6,544 items checked.
- 21 items reported.
- No scan errors.
- The SSL certificate uses CN=localhost, which does not match the hostname used during scanning.

## Findings and Risk Analysis

### 1. Directory Indexing
Severity: Medium

Nikto detected directory indexing in:
- /dvwa/config/
- /dvwa/tests/
- /dvwa/database/
- /dvwa/images/
- /dvwa/docs/

Risk:
Directory listings may expose files and application structure to unauthorised visitors.

Recommendation:
Disable directory listing in Apache using the appropriate Options -Indexes configuration. Restrict access to sensitive directories and remove unnecessary test files from production systems.

### 2. Configuration Directory Exposure
Severity: Medium

Nikto reported that configuration information may be available remotely under /dvwa/config/.

Risk:
Exposed configuration files could reveal sensitive application details or credentials if accessible.

Recommendation:
Restrict access to configuration directories and ensure sensitive files cannot be downloaded through a browser. Verify exposure manually before treating this as a confirmed data leak.

### 3. HTTP TRACE Method Enabled
Severity: Medium

Nikto detected that the HTTP TRACE method is active.

Risk:
TRACE can potentially contribute to Cross-Site Tracing attacks in certain configurations.

Recommendation:
Disable TRACE in Apache using:

TraceEnable off

Restart Apache and test the method again.

### 4. Missing X-Frame-Options Header
Severity: Low

Nikto reported that the anti-clickjacking X-Frame-Options header is missing.

Risk:
The application may be more exposed to clickjacking attacks.

Recommendation:
Configure X-Frame-Options with SAMEORIGIN or DENY, and consider using a Content-Security-Policy frame-ancestors directive.

### 5. Server Information Disclosure
Severity: Low

The server disclosed Apache, Windows, OpenSSL and PHP version information. The X-Powered-By header also disclosed PHP/8.3.36.

Risk:
Attackers may use version information to identify potentially vulnerable software.

Recommendation:
Reduce unnecessary server information disclosure. Review Apache ServerTokens and ServerSignature settings and disable PHP expose_php where appropriate.

### 6. ETag Information Disclosure
Severity: Low

Nikto reported that the server may disclose inode information through ETag headers.

Risk:
This may expose unnecessary server or file metadata.

Recommendation:
Review Apache FileETag configuration and limit unnecessary metadata disclosure.

### 7. Cookie Security Flags
Severity: Medium

Nikto reported that cookies were missing Secure and HttpOnly flags during the HTTPS scan.

Risk:
Missing Secure may allow cookies to be sent over unencrypted connections. Missing HttpOnly can increase exposure to cookie theft through certain script-based attacks.

Manual verification:
A separate curl response showed HttpOnly on the observed cookies, but the Secure flag was not shown. The scanner result should therefore be manually investigated rather than treated as fully confirmed.

Recommendation:
Configure session cookies with Secure, HttpOnly and an appropriate SameSite policy. Re-test after configuration.

### 8. SSL Certificate Hostname Mismatch
Severity: Low

The certificate common name is localhost, while the scan used Samukelo_Sofala.mshome.net.

Risk:
Browsers and clients may warn that the certificate does not match the hostname.

Recommendation:
Use a certificate whose subject alternative name matches the hostname used to access the application.

### 9. robots.txt and Login Page
Severity: Informational

Nikto identified a robots.txt entry and the DVWA login page.

Risk:
These are observations, not confirmed vulnerabilities. robots.txt should not be used to protect sensitive resources.

Recommendation:
Review robots.txt for unnecessary disclosures and protect login functionality with strong authentication and appropriate access controls.

## What Is a Noisy Scanner?

Nikto is considered noisy because it sends many HTTP requests to test web server paths, files, headers and configurations. These requests can appear in server logs, trigger security alerts or be blocked by protective systems.

## Nikto vs Nmap

Nikto focuses on web server and web application checks, including exposed files, HTTP methods and security headers.

Nmap focuses on network discovery, open ports, running services and service versions. Nmap can also use scripts to investigate specific services.

The tools complement each other but serve different purposes.

## Limitations

- Nikto findings may include false positives.
- Results require manual verification.
- A scan does not prove that a system is exploitable.
- The scan does not replace manual security testing or a full penetration test.
- The installed Nikto package is version 2.1.5.

## Ethical Considerations

All scans in this task were performed against a local DVWA test environment. Scanning systems without permission is not authorised.

## References

- Nikto: https://github.com/sullo/nikto
- OWASP Top 10: https://owasp.org/Top10/
