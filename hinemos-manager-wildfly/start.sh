#!/bin/bash
# Start Hinemos Manager and Web as hinemos user
su - hinemos -c "/opt/hinemos/bin/hinemos_manager start"
su - hinemos -c "/opt/hinemos/bin/hinemos_web start"

# Start WildFly as wildfly user
su - wildfly -c "/opt/wildfly/bin/standalone.sh -b 0.0.0.0 &"
sleep 5
exec "$@"
