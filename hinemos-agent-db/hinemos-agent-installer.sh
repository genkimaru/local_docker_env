#!/bin/bash
set -e

# Variables
HINEMOS_VERSION=7.1.1
AGENT_RPM=https://github.com/hinemos/hinemos/releases/download/v${HINEMOS_VERSION}/hinemos-7.1-agent-${HINEMOS_VERSION}-1.el8.x86_64.rpm

# Create hinemos user and group if not exist
if ! id hinemos &>/dev/null; then
    groupadd -r hinemos
    useradd -r -g hinemos -d /opt/hinemos -s /sbin/nologin hinemos
fi

# Install dependencies
yum install -y wget java-17-openjdk

# Download and install Hinemos Agent
wget -O /tmp/hinemos-agent.rpm "$AGENT_RPM"
rpm -ivh /tmp/hinemos-agent.rpm

# Set permissions
chown -R hinemos:hinemos /opt/hinemos || true

# Clean up
rm -f /tmp/hinemos-agent.rpm

echo "Hinemos Agent installation complete."
