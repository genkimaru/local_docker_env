FROM almalinux:8.6

# Install dependencies
RUN dnf install -y wget tar java-17-openjdk java-17-openjdk-devel && \
    dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    dnf -qy module disable postgresql && \
    dnf install -y postgresql16-server postgresql16 && \
    dnf clean all

# Initialize PostgreSQL
RUN /usr/pgsql-16/bin/postgresql-16-setup initdb

# Install Hinemos Agent (v7.1.1)
ENV HINEMOS_VERSION=7.1.1
RUN groupadd -r hinemos && useradd -r -g hinemos -d /opt/hinemos -s /sbin/nologin hinemos
RUN wget -O /tmp/hinemos-agent.rpm "https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-agent-${HINEMOS_VERSION}-1.el8.x86_64.rpm" && \
    rpm -ivh /tmp/hinemos-agent.rpm && \
    chown -R hinemos:hinemos /opt/hinemos && \
    rm -f /tmp/hinemos-agent.rpm

# Expose PostgreSQL port
EXPOSE 5432

# Default command (can be customized)
CMD ["/usr/pgsql-16/bin/postgres", "-D", "/var/lib/pgsql/16/data"]
