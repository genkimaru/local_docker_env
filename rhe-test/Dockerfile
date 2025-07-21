FROM rockylinux:8

# Update and install basic utilities (optional)
RUN dnf clean all && \
    dnf makecache && \
    dnf update -y && \
    dnf install -y sudo vim less which curl wget tar && \
    dnf clean all

CMD ["/bin/bash"]
