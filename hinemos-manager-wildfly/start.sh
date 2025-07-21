#!/bin/bash
# Start Hinemos Manager as hinemos-manager user
su - hinemos-manager -c "/opt/hinemos-manager/bin/hinemos_manager start"
# Start Hinemos Web as hinemos-web user
su - hinemos-web -c "/opt/hinemos-web/bin/hinemos_web start"

# Start WildFly as wildfly user
su - wildfly -c "/opt/wildfly/bin/standalone.sh -b 0.0.0.0 &"
sleep 5
exec "$@"
