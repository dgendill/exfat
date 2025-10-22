# Use Ubuntu 18.04 (Bionic Beaver) which officially uses GLIBC 2.27
FROM ubuntu:18.04

COPY . /home

# Set environment variable for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required tools.
# --no-install-recommends helps keep the image lightweight.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        autoconf \
        automake \
        pkg-config \
        gcc \
        make \
        # 'libfuse-dev' is the Debian/Ubuntu package name for 'fuse-devel'
        libfuse-dev && \
    \
    # Cleanup to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home
RUN autoreconf --install && ./configure && make && make install

CMD ["bash"]
