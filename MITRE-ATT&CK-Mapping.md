# AWSGoat Attack Manuals - MITRE ATT&CK Framework Mapping

This document maps the attack techniques demonstrated in the AWSGoat project to the MITRE ATT&CK framework, providing a structured view of the tactics and techniques covered.

## Executive Summary

The AWSGoat project contains 11 attack scenarios across 2 modules demonstrating various web application vulnerabilities and cloud-specific attack techniques. These attacks map to multiple MITRE ATT&CK tactics including Initial Access, Execution, Persistence, Privilege Escalation, Defense Evasion, Credential Access, Discovery, and Collection.

---

## Module 1: Web Application & AWS Lambda Attacks

### 1. Reflected XSS (Cross-Site Scripting)

**File:** [module-1/01-Reflected XSS.md](attack-manuals/module-1/01-Reflected%20XSS.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Initial Access
- **Technique:** T1189 - Drive-by Compromise
- **Sub-technique:** T1059.007 - JavaScript
- **Description:** Exploits lack of input validation to inject malicious JavaScript into web applications, executing in victim browsers.

---

### 2. SQL Injection (Module 1)

**File:** [module-1/02-SQL Injection.md](attack-manuals/module-1/02-SQL%20Injection.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Initial Access, Collection
- **Technique:** T1190 - Exploit Public-Facing Application
- **Technique:** T1213 - Data from Information Repositories
- **Description:** Exploits inadequate input sanitization to manipulate SQL queries and extract sensitive database information including user credentials, PII, and security questions.

---

### 3. Insecure Direct Object Reference (IDOR)

**File:** [module-1/03-Insecure Direct Object Reference.md](attack-manuals/module-1/03-Insecure%20Direct%20Object%20Reference.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Privilege Escalation, Defense Evasion
- **Technique:** T1548 - Abuse Elevation Control Mechanism
- **Technique:** T1552.001 - Unsecured Credentials: Credentials In Files
- **Description:** Manipulates user ID parameters to access and modify data belonging to other users, enabling unauthorized password changes and account takeover.

---

### 4. Sensitive Data Exposure

**File:** [module-1/04-Sensitive Data Exposure.md](attack-manuals/module-1/04-Sensitive%20Data%20Exposure.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Discovery, Collection
- **Technique:** T1083 - File and Directory Discovery
- **Technique:** T1213 - Data from Information Repositories
- **Technique:** T1595.002 - Active Scanning: Vulnerability Scanning
- **Description:** Uses OWASP ZAP fuzzer to discover unprotected API endpoints (dump) that expose sensitive user data including credentials and PII.

---

### 5. Server-Side Request Forgery (SSRF) - Part 1

**File:** [module-1/05-Server Side Request Forgery Part 1.md](attack-manuals/module-1/05-Server%20Side%20Request%20Forgery%20Part%201.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Collection, Discovery
- **Technique:** T1046 - Network Service Discovery
- **Technique:** T1005 - Data from Local System
- **Technique:** T1082 - System Information Discovery
- **Description:** Exploits image URL field to access local file system (file:///etc/passwd) in Lambda execution environment.

---

### 6. Server-Side Request Forgery (SSRF) - Part 2

**File:** [module-1/06-Server Side Request Forgery Part 2.md](attack-manuals/module-1/06-Server%20Side%20Request%20Forgery%20Part%202.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Credential Access, Discovery, Persistence
- **Technique:** T1552.005 - Unsecured Credentials: Cloud Instance Metadata API
- **Technique:** T1078.004 - Valid Accounts: Cloud Accounts
- **Technique:** T1136.003 - Create Account: Cloud Account
- **Description:** Advanced SSRF attack accessing Lambda Runtime API and environment variables to extract AWS credentials, enumerate DynamoDB tables, and inject malicious administrator user into database.

---

### 7. IAM Privilege Escalation (Module 1)

**File:** [module-1/07-IAM Privilege Escalation.md](attack-manuals/module-1/07-IAM%20Privilege%20Escalation.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Privilege Escalation, Credential Access, Discovery, Lateral Movement
- **Technique:** T1078.004 - Valid Accounts: Cloud Accounts
- **Technique:** T1552.001 - Unsecured Credentials: Credentials In Files
- **Technique:** T1580 - Cloud Infrastructure Discovery
- **Technique:** T1021.007 - Remote Services: Cloud Services
- **Technique:** T1548.005 - Abuse Elevation Control Mechanism: Temporary Elevated Cloud Access
- **Description:** Discovers misconfigured S3 bucket allowing access to sensitive configuration files containing SSH keys. Uses credentials to access EC2 instance, enumerates IAM roles/policies, creates overly permissive policy, attaches it to Lambda role, and creates new administrator user.

---

## Module 2: Container & ECS Attacks

### 8. SQL Injection (Module 2)

**File:** [module-2/01-SQL Injection.md](attack-manuals/module-2/01-SQL%20Injection.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Initial Access, Persistence
- **Technique:** T1190 - Exploit Public-Facing Application
- **Technique:** T1078 - Valid Accounts
- **Description:** Demonstrates multiple SQL injection payloads including authentication bypass and SQL clauses (LIMIT, ORDER BY) to access different user privilege levels (normal user, manager, admin) in PHP application.

---

### 9. File Upload and Task Metadata

**File:** [module-2/02-File Upload and Task Metadata.md](attack-manuals/module-2/02-File%20Upload%20and%20Task%20Metadata.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Execution, Initial Access, Credential Access, Discovery
- **Technique:** T1203 - Exploitation for Client Execution
- **Technique:** T1059.004 - Command and Scripting Interpreter: Unix Shell
- **Technique:** T1552.005 - Unsecured Credentials: Cloud Instance Metadata API
- **Technique:** T1087.004 - Account Discovery: Cloud Account
- **Technique:** T1580 - Cloud Infrastructure Discovery
- **Description:** Uploads PHP reverse shell via manager account to gain shell access in ECS container. Extracts ECS task metadata and credentials via AWS_CONTAINER_CREDENTIALS_RELATIVE_URI. Accesses AWS Secrets Manager to retrieve RDS credentials.

---

### 10. ECS Breakout and Instance Metadata

**File:** [module-2/03-ECS Breakout and Instance Metadata.md](attack-manuals/module-2/03-ECS Breakout and Instance Metadata.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Privilege Escalation, Defense Evasion, Credential Access, Discovery
- **Technique:** T1611 - Escape to Host
- **Technique:** T1548.003 - Abuse Elevation Control Mechanism: Sudo and Sudo Caching
- **Technique:** T1055.008 - Process Injection: Ptrace System Calls
- **Technique:** T1552.005 - Unsecured Credentials: Cloud Instance Metadata API
- **Technique:** T1068 - Exploitation for Privilege Escalation
- **Description:** Escalates from www-data to root using sudo vim vulnerability. Exploits SYS_PTRACE capability to inject TCP bind shell shellcode into host process, breaking out of container. Accesses EC2 Instance Metadata Service (IMDS) to retrieve IAM role credentials.

---

### 11. IAM Privilege Escalation (Module 2)

**File:** [module-2/04-IAM Privilege Escalation.md](attack-manuals/module-2/04-IAM%20Privilege%20Escalation.md)

**MITRE ATT&CK Mapping:**
- **Tactic:** Privilege Escalation, Persistence, Execution
- **Technique:** T1098.001 - Account Manipulation: Additional Cloud Credentials
- **Technique:** T1136.003 - Create Account: Cloud Account
- **Technique:** T1484 - Domain Policy Modification
- **Technique:** T1550.001 - Use Alternate Authentication Material: Application Access Token
- **Technique:** T1078.004 - Valid Accounts: Cloud Accounts
- **Description:** Discovers IAM permissions boundary restricting direct user creation. Identifies ec2Deployer-role with full permissions. Launches new EC2 instance with iam:PassRole, uses SSM to execute commands and extract role credentials. Creates administrator user bypassing permissions boundary.

---

## Summary by MITRE ATT&CK Tactics

### Initial Access
- T1189 - Drive-by Compromise (XSS)
- T1190 - Exploit Public-Facing Application (SQL Injection, File Upload)
- T1203 - Exploitation for Client Execution (Reverse Shell)

### Execution
- T1059.004 - Unix Shell (Reverse Shell)
- T1059.007 - JavaScript (XSS)

### Persistence
- T1078.004 - Valid Accounts: Cloud Accounts
- T1136.003 - Create Account: Cloud Account

### Privilege Escalation
- T1068 - Exploitation for Privilege Escalation (Container Escape)
- T1548.003 - Sudo and Sudo Caching
- T1548.005 - Temporary Elevated Cloud Access
- T1548 - Abuse Elevation Control Mechanism (IDOR)

### Defense Evasion
- T1548 - Abuse Elevation Control Mechanism
- T1611 - Escape to Host (Container Breakout)

### Credential Access
- T1552.001 - Credentials In Files
- T1552.005 - Cloud Instance Metadata API (Lambda, ECS, EC2 IMDS)
- T1078 - Valid Accounts

### Discovery
- T1046 - Network Service Discovery
- T1082 - System Information Discovery
- T1083 - File and Directory Discovery
- T1087.004 - Cloud Account Discovery
- T1580 - Cloud Infrastructure Discovery
- T1595.002 - Vulnerability Scanning

### Collection
- T1005 - Data from Local System
- T1213 - Data from Information Repositories

### Lateral Movement
- T1021.007 - Cloud Services

---

## Cloud-Specific Attack Patterns

### AWS Lambda Attacks
- Lambda Runtime API exploitation (SSRF)
- Environment variable extraction
- DynamoDB direct access via credentials

### AWS ECS/Container Attacks
- ECS task role credential extraction
- Container escape via SYS_PTRACE
- Secrets Manager credential harvesting

### AWS IAM Attacks
- Privilege escalation via policy manipulation
- Permission boundary bypass via PassRole
- SSM command execution for credential extraction

### AWS Metadata Service Attacks
- EC2 IMDS credential extraction
- ECS task metadata exploitation
- Lambda environment introspection

---

## Defense Recommendations by Attack Type

### Web Application Security
1. **Input Validation:** Implement strict input sanitization to prevent XSS and SQL injection
2. **Authorization Controls:** Enforce proper access controls and validate object ownership (IDOR)
3. **File Upload Security:** Validate file types on backend and isolate upload execution environments
4. **API Security:** Implement authentication on all API endpoints and avoid predictable naming

### Cloud Security

#### AWS Lambda
- Minimize Lambda IAM role permissions (principle of least privilege)
- Disable unnecessary AWS service access
- Use VPC endpoints to restrict network access
- Implement request validation and rate limiting

#### AWS ECS
- Avoid privileged containers and dangerous capabilities (SYS_PTRACE)
- Implement read-only root filesystems
- Use security profiles (AppArmor/SELinux)
- Restrict sudo access in containers
- Enable task-level IAM roles with minimal permissions

#### AWS IAM
- Implement permission boundaries on all roles
- Monitor for privilege escalation patterns
- Restrict PassRole permissions
- Enable AWS CloudTrail for IAM activity logging
- Implement SCPs (Service Control Policies) for organization-wide controls

#### AWS Metadata Services
- Use IMDSv2 (session-based) instead of IMDSv1
- Implement network hop limits
- Monitor metadata service access
- Use VPC endpoints where possible

### General Cloud Security
1. **Secret Management:** Never store credentials in code, use AWS Secrets Manager or Parameter Store
2. **Network Security:** Implement VPC isolation and security groups
3. **Monitoring:** Enable comprehensive logging (CloudTrail, VPC Flow Logs, CloudWatch)
4. **Compliance:** Regular security assessments and penetration testing
5. **Infrastructure as Code:** Use tools like Terraform or CloudFormation with security scanning

---

## Attack Kill Chain Summary

```
Module 1 Kill Chain:
Web Vuln (XSS/SQLi/IDOR) → SSRF → Lambda Credentials → DynamoDB Access → Admin Account Creation

Module 2 Kill Chain:
SQLi Auth Bypass → File Upload → Reverse Shell → Container Creds → ECS Metadata → 
Container Escape → EC2 IMDS → IAM Enumeration → PassRole Abuse → Admin Creation
```

---

## References

- [MITRE ATT&CK Cloud Matrix](https://attack.mitre.org/matrices/enterprise/cloud/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)

---

**Document Version:** 1.0  
**Last Updated:** 2026-05-27  
**Project:** FortiShield AWSGoat Security Assessment
