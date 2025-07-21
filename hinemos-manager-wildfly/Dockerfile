FROM rockylinux:8

# Import GPG keys and install dependencies
RUN dnf makecache && \
    dnf install -y wget tar java-17-openjdk java-17-openjdk-devel vim-common  unzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf/* /tmp/*

# Create users and directories for services
RUN groupadd -r hinemos-manager && useradd -r -g hinemos-manager -d /opt/hinemos-manager -s /sbin/nologin hinemos-manager && \
    groupadd -r hinemos-web && useradd -r -g hinemos-web -d /opt/hinemos-web -s /sbin/nologin hinemos-web && \
    groupadd -r wildfly && useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly && \
    mkdir -p /opt/hinemos-manager /opt/hinemos-web

# Install Hinemos Manager and Web Client (v7.1.1)
ENV HINEMOS_VERSION=7.1.1
RUN wget -O /tmp/hinemos-manager.rpm "https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-manager-${HINEMOS_VERSION}-1.el8.x86_64.rpm" && \
    wget -O /tmp/hinemos-web.rpm "https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-web-${HINEMOS_VERSION}-1.el8.x86_64.rpm" && \
    rpm -ivh /tmp/hinemos-manager.rpm /tmp/hinemos-web.rpm && \
    chown -R hinemos-manager:hinemos-manager /opt/hinemos-manager && \
    chown -R hinemos-web:hinemos-web /opt/hinemos-Web && \
    rm -f /tmp/hinemos-manager.rpm /tmp/hinemos-web.rpm

# After installing Hinemos, set ownership for manager and web users
RUN chown -R hinemos-manager:hinemos-manager /opt/hinemos-manager && \
    chown -R hinemos-web:hinemos-web /opt/hinemos-web && \
    chown -R hinemos-manager:hinemos-manager /opt/hinemos-manager && \
    chown -R hinemos-web:hinemos-web /opt/hinemos-web

# Install WildFly 27
ENV WILDFLY_VERSION=27.0.1.Final
RUN wget -O /tmp/wildfly.tar.gz "https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz" && \
    mkdir -p /opt/wildfly && \
    tar -xzf /tmp/wildfly.tar.gz -C /opt/wildfly --strip-components=1 && \
    rm -f /tmp/wildfly.tar.gz && \
    chown -R wildfly:wildfly /opt/wildfly

# Copy startup script and ensure permissions
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh && chown root:root /usr/local/bin/start.sh

# Expose ports for Hinemos Manager and WildFly
EXPOSE 8080 9990

# Default command
CMD ["/usr/local/bin/start.sh", "tail", "-f", "/dev/null"]
