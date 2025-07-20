FROM almalinux:8.6

# Import GPG keys and install dependencies
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux && \
    dnf makecache && \
    dnf install -y wget tar java-17-openjdk java-17-openjdk-devel && \
    dnf clean all

# Install Hinemos Manager and Web Client (v7.1.1)
ENV HINEMOS_VERSION=7.1.1
RUN groupadd -r hinemos && useradd -r -g hinemos -d /opt/hinemos -s /sbin/nologin hinemos
RUN wget -O /tmp/hinemos-manager.rpm "https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-manager-${HINEMOS_VERSION}-1.el8.x86_64.rpm" && \
    wget -O /tmp/hinemos-web.rpm "https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-web-${HINEMOS_VERSION}-1.el8.x86_64.rpm" && \
    rpm -ivh /tmp/hinemos-manager.rpm /tmp/hinemos-web.rpm && \
    chown -R hinemos:hinemos /opt/hinemos && \
    rm -f /tmp/hinemos-manager.rpm /tmp/hinemos-web.rpm

# Install WildFly 27
ENV WILDFLY_VERSION=27.0.1.Final
RUN wget -O /tmp/wildfly.tar.gz "https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz" && \
    mkdir -p /opt/wildfly && \
    tar -xzf /tmp/wildfly.tar.gz -C /opt/wildfly --strip-components=1 && \
    rm -f /tmp/wildfly.tar.gz && \
    chown -R hinemos:hinemos /opt/wildfly

# Create startup script
RUN echo '#!/bin/bash\n\
# Start Hinemos Manager services\n\
systemctl start hinemos-manager || true\n\
systemctl start hinemos-web || true\n\
\n\
# Start WildFly\n\
su - hinemos -c "/opt/wildfly/bin/standalone.sh -b 0.0.0.0 &\n\
exec "$@"' > /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start.sh

# Expose ports for Hinemos Manager and WildFly
EXPOSE 8080 9990

# Default command
CMD ["/usr/local/bin/start.sh", "tail", "-f", "/dev/null"]
