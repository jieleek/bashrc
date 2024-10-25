FROM node:20.9

# Install basic development tools
RUN apt update && apt install -y less git

# [Optional] Install any global packages you need
RUN npm install -g npm@10.3.0

# Ensure default `node` user has access to `npm global`
RUN mkdir -p /home/node/.npm-global && \
    chown -R node:node /home/node/.npm-global

# Set up non-root user
USER node

# Configure npm to use the new directory path
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

# Set the working directory
WORKDIR /workspace


