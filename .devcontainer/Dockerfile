FROM node:20-bullseye-slim

# Install system tools — all in one RUN to keep layers small
RUN apt-get update && apt-get install -y \
      git curl netcat-openbsd sudo docker.io \
      && apt-get clean && rm -rf /var/lib/apt/lists/*

# Give node user sudo access without password prompt
RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure /home/node exists with correct ownership
# node:20 image has the node user but /home/node may not exist
RUN mkdir -p /home/node && chown -R node:node /home/node

USER node
WORKDIR /workspace
