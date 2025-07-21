#!/bin/bash
# Start Hinemos Manager services
systemctl start hinemos-manager || true
systemctl start hinemos-web || true

# Start WildFly as wildfly user
su - wildfly -c "/opt/wildfly/bin/standalone.sh -b 0.0.0.0 &"
sleep 5
exec "$@"
