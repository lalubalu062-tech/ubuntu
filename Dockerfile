FROM ubuntu:latest

# Basic tools aur sudo install karein
RUN apt-get update && apt-get install -y \
    sudo \
    python3 \
    python3-pip \
    curl \
    wget \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Naya user 'jeet22' banayein aur password 'jeet22' set karein
RUN useradd -m -s /bin/bash jeet22 && \
    echo "jeet22:jeet22" | chpasswd && \
    usermod -aG sudo jeet22

# Container start hone par default user jeet22 set karein
USER jeet22
WORKDIR /home/jeet22

# Container ko background me chalte rahne ke liye command
CMD ["tail", "-f", "/dev/null"]

