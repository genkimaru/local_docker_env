FROM almalinux:8.6

# Install Java 17
RUN dnf install -y java-17-openjdk java-17-openjdk-devel && \
    dnf clean all

# Placeholder: Install Hinemos Manager (manual or script installation required)
# COPY hinemos-manager-installer.sh /tmp/
# RUN bash /tmp/hinemos-manager-installer.sh

CMD ["/bin/bash"]
