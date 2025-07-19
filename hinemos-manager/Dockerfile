FROM almalinux:8.6

# Install Java 17
RUN dnf install -y java-17-openjdk java-17-openjdk-devel && \
    dnf clean all

# Placeholder: Add Hinemos Manager installer script
COPY hinemos-manager-installer.sh /tmp/
RUN chmod +x /tmp/hinemos-manager-installer.sh && /tmp/hinemos-manager-installer.sh

CMD ["/bin/bash"]
