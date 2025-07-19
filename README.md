# Docker Compose Architecture Plan

This project uses Docker Compose to orchestrate two main containers, each with specific roles and software requirements as described below:

## 1. Hinemos Manager & WildFly Container

- **Base OS:** Red Hat Enterprise Linux 8.6 (or equivalent free OS, e.g., AlmaLinux 8.6)
- **Java:** Version 17
- **Hinemos Manager:** Installed
- **WildFly:** Version 27
- **Purpose:** Central management and monitoring node for Hinemos, and provides an application server environment.

## 2. Hinemos Agent & PostgreSQL Container

- **Base OS:** Red Hat Enterprise Linux 8.6 (or equivalent free OS, e.g., AlmaLinux 8.6)
- **PostgreSQL:** Version 16
- **Hinemos Agent:** Installed
- **Purpose:** Provides a PostgreSQL database and exposes a Hinemos Agent that can be managed by the Hinemos Manager container.

---

## Example `docker-compose.yml` Structure

```yaml
version: '3.8'
services:
  hinemos-manager-wildfly:
    build:
      context: ./hinemos-manager-wildfly
    image: hinemos-manager-wildfly:latest
    container_name: hinemos-manager-wildfly
    ports:
      - '8080:8080' # Hinemos Manager UI or WildFly HTTP
      - '9990:9990' # WildFly management
    environment:
      - JAVA_VERSION=17
    # Additional setup for Hinemos Manager and WildFly in Dockerfile

  hinemos-agent-db:
    build:
      context: ./hinemos-agent-db
    image: hinemos-agent-db:latest
    container_name: hinemos-agent-db
    environment:
      - POSTGRES_USER=hinemos
      - POSTGRES_PASSWORD=hinemos
      - POSTGRES_DB=hinemos
    ports:
      - '5432:5432'
    # Additional setup for Hinemos Agent and PostgreSQL in Dockerfile
```

> **Note:** Each service will require a custom Dockerfile in its respective context directory to install and configure Hinemos Manager, Hinemos Agent, WildFly, and PostgreSQL as needed. The above is a high-level plan; see the `prd.md` for detailed requirements.

---

## Getting Started

Follow these steps to build and start the project using Docker Compose:

1. **Clone the repository** (if you haven't already):

   ```bash
   git clone <your-repo-url>
   cd oculus-monitor
   ```

2. **Build the Docker images and start the containers:**

   ```bash
   docker-compose up --build
   ```

   This command will build the images for all services and start the containers as defined in `docker-compose.yml`.

3. **Access the services:**

   - **Hinemos Manager UI:** http://localhost:8080 (or the port you configured)
   - **PostgreSQL:** localhost:5432 (default credentials: user `hinemos`, password `hinemos`)
   - **WildFly Management:** http://localhost:9990
   - **WildFly HTTP:** http://localhost:8081

4. **Stopping the services:**
   ```bash
   docker-compose down
   ```
   This will stop and remove the containers.

> **Note:** The Dockerfiles contain placeholders for installing Hinemos Manager, Hinemos Agent, and Hulft. You will need to provide the appropriate installation scripts or manual steps to complete the setup.
