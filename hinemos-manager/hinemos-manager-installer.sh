#!/bin/bash
set -e

# Variables
HINEMOS_VERSION=7.1.1
MANAGER_RPM=https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-manager-${HINEMOS_VERSION}-1.el8.x86_64.rpm
WEB_RPM=https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-web-${HINEMOS_VERSION}-1.el8.x86_64.rpm

# Create hinemos user and group if not exist
if ! id hinemos &>/dev/null; then
    groupadd -r hinemos
    useradd -r -g hinemos -d /opt/hinemos -s /sbin/nologin hinemos
fi

# Install dependencies
yum install -y wget java-17-openjdk

# Download and install Hinemos Manager
wget -O /tmp/hinemos-manager.rpm "$MANAGER_RPM"
rpm -ivh /tmp/hinemos-manager.rpm

# Download and install Hinemos Web Client
wget -O /tmp/hinemos-web.rpm "$WEB_RPM"
rpm -ivh /tmp/hinemos-web.rpm

# Set permissions
chown -R hinemos:hinemos /opt/hinemos || true

# Clean up
rm -f /tmp/hinemos-manager.rpm /tmp/hinemos-web.rpm

echo "Hinemos Manager and Web Client installation complete."
