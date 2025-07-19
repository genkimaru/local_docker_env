FROM jboss/wildfly:18.0.0.Final

# Java 8 is already present in the base image

# Placeholder: Add Hulft 8 installer script
COPY hulft8-installer.sh /tmp/
RUN chmod +x /tmp/hulft8-installer.sh && /tmp/hulft8-installer.sh

# Placeholder: Add Hinemos Agent installer script
COPY hinemos-agent-installer.sh /tmp/
RUN chmod +x /tmp/hinemos-agent-installer.sh && /tmp/hinemos-agent-installer.sh

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
