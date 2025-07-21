FROM rockylinux:8

RUN dnf clean all && \
    dnf makecache && \
    dnf update  -y ca-certificates && \
    dnf install -y wget tar java-17-openjdk java-17-openjdk-devel && \
    dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-aarch64/pgdg-redhat-repo-latest.noarch.rpm && \
    ls -la /etc/pki/rpm-gpg/ && \
    chmod 755 /etc/pki/rpm-gpg/PGDG-RPM-GPG-KEY-AARCH64-RHEL && \
    rpm --import /etc/pki/rpm-gpg/PGDG-RPM-GPG-KEY-AARCH64-RHEL && \
    dnf -qy module disable postgresql && \
    dnf install -y postgresql16-server postgresql16 && \
    dnf clean all && \
    rm -rf /var/cache/dnf/* /tmp/*

# Create PGDATA directory and set permissions
RUN mkdir -p /var/lib/pgsql/16/data && \
    chown -R postgres:postgres /var/lib/pgsql/16/data

# Initialize PostgreSQL as postgres user
USER postgres
RUN /usr/pgsql-16/bin/initdb -D /var/lib/pgsql/16/data

USER root

# Create hinemos user and group for Hinemos installation
RUN groupadd -r hinemos && useradd -r -g hinemos -d /opt/hinemos -s /sbin/nologin hinemos && \
    mkdir -p /opt/hinemos

# Install Hinemos Agent (v7.1.1)
RUN wget -O /tmp/hinemos-agent.rpm https://github.com/hinemos/hinemos/releases/download/v7.1.1/hinemos-7.1-agent-7.1.1-1.el.noarch.rpm && \
    rpm -ivh /tmp/hinemos-agent.rpm && \
    chown -R hinemos:hinemos /opt/hinemos && \
    rm -f /tmp/hinemos-agent.rpm

# Copy entrypoint script and ensure permissions
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5432

CMD ["/usr/local/bin/start.sh", "tail", "-f", "/dev/null"]
