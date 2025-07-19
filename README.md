# Docker Compose Architecture Plan

This project uses Docker Compose to orchestrate three main containers, each with specific roles and software requirements as described below:

## 1. Hinemos Manager Container

- **Base OS:** Red Hat Enterprise Linux 8.6 (or equivalent free OS, e.g., AlmaLinux 8.6)
- **Java:** Version 17
- **Software:** Hinemos Manager
- **Purpose:** Central management and monitoring node for Hinemos.

## 2. Hinemos Agent & PostgreSQL Container

- **Base OS:** (Compatible with PostgreSQL 16 and Hinemos Agent)
- **PostgreSQL:** Version 16
- **Software:** Hinemos Agent
- **Purpose:** Provides a PostgreSQL database and exposes a Hinemos Agent that can be managed by the Hinemos Manager container.

## 3. WildFly, Hulft & Hinemos Agent Container

- **Base OS:** (Compatible with WildFly 18, Hulft 8, and Hinemos Agent)
- **WildFly:** Version 18
- **Java:** Version 8
- **Software:** Hulft Version 8, Hinemos Agent
- **Purpose:** Application server environment with file transfer middleware and a Hinemos Agent that can be managed by the Hinemos Manager container.

---

## Example docker-compose.yml Structure

```yaml
version: '3.8'
services:
  hinemos-manager:
    image: almalinux:8.6 # Or rhel8.6 if available
    container_name: hinemos-manager
    build:
      context: ./hinemos-manager
    ports:
      - '8080:8080' # Example port for Hinemos Manager UI
    environment:
      - JAVA_VERSION=17
    # Additional setup for Hinemos Manager in Dockerfile

  hinemos-agent-db:
    image: postgres:16
    container_name: hinemos-agent-db
    build:
      context: ./hinemos-agent-db
    environment:
      - POSTGRES_USER=hinemos
      - POSTGRES_PASSWORD=hinemos
      - POSTGRES_DB=hinemos
    ports:
      - '5432:5432'
    # Additional setup for Hinemos Agent in Dockerfile

  wildfly-hulft-agent:
    image: jboss/wildfly:18.0.0.Final
    container_name: wildfly-hulft-agent
    build:
      context: ./wildfly-hulft-agent
    environment:
      - JAVA_VERSION=8
    # Additional setup for Hulft and Hinemos Agent in Dockerfile
```

> **Note:** Each service may require a custom Dockerfile in its respective context directory to install and configure Hinemos Manager, Hinemos Agent, and Hulft as needed. The above is a high-level plan; see the `prd.md` for detailed requirements.
