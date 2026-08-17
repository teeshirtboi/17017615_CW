# CYBERDELIA – Container Security Hardening

**Module:** 7009SCN – Cloud and Container Security  
**Student ID:** 17017615  
**Application UID:** 20615  
**Application Port:** 8015  

## 1. Project Overview

This project implements security hardening for the CYBERDELIA containerised web application.

The original deployment was reviewed and hardened to reduce the attack surface, limit container privileges, improve resource control, reduce unnecessary software, and improve vulnerability management.

The final deployment consists of:

- A hardened web application container
- A PostgreSQL database container
- Docker Compose for deployment and service management
- Nginx as the reverse proxy
- Alpine Linux with Python 3.11 for the web runtime
- Trivy for container vulnerability scanning

---

## 2. Security Hardening

The final implementation applies the following security controls:

### Non-root execution

The web application runs using the dedicated application account:

```text
UID: 20615
GID: 20615
User: appuser
