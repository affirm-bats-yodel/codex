# Source:
#
# https://github.com/openai/codex/blob/b6e3f3f8dd8f82bbf94084895076bb0df2603aaf/codex-cli/Dockerfile
FROM node:23.11-slim

ARG TZ
ENV TZ="${TZ}"

# Install basic development tools, ca-certificates, and iptables/ipset, then clean up apt cache to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
  aggregate \
  ca-certificates \
  curl \
  dnsutils \
  fzf \
  gh \
  git \
  gnupg2 \
  iproute2 \
  ipset \
  iptables \
  jq \
  less \
  man-db \
  procps \
  sudo \
  unzip \
  ripgrep \
  zsh \
  vim \
  locales \
  && rm -rf /var/lib/apt/lists/*

# Install glab binary via deb and remove cache
ARG TARGETARCH
ARG GLAB_VERSION="1.55.0"
RUN curl -LO https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_${TARGETARCH}.deb && \
  apt-get install --yes ./glab_1.55.0_linux_amd64.deb && \
  rm -rf ./glab_${GLAB_VERSION}_linux_${TARGETARCH}.deb && \
  rm -rf /var/lib/apt/lists/*

# Ensure default node user has access to /usr/local/share
RUN mkdir -p /usr/local/share/npm-global && \
  chown -R node:node /usr/local/share

# Set up non-root user
USER node

# Install global packages
ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=$PATH:/usr/local/share/npm-global/bin

# Install codex
# 
# https://www.npmjs.com/package/@openai/codex/v/0.1.2504251709
ARG CODEX_VERSION="0.1.2504251709"
RUN npm i -g @openai/codex@${CODEX_VERSION} && \
  npm cache clean --force

# Copy and set up firewall, workspace script
COPY scripts/init_firewall.sh /usr/local/bin/
COPY scripts/init_workspace.sh /usr/local/bin/
USER root
RUN chmod +x /usr/local/bin/init_firewall.sh && \
  echo "node ALL=(root) NOPASSWD: /usr/local/bin/init_firewall.sh" > /etc/sudoers.d/node-firewall && \
  chmod 0440 /etc/sudoers.d/node-firewall && \
  chmod +x /usr/local/bin/init_workspace.sh && \
  echo "node ALL=(root) NOPASSWD: /usr/local/bin/init_workspace.sh" > /etc/sudoers.d/node-workspace-init && \
  chmod 0440 /etc/sudoers.d/node-workspace-init
USER node

# Set default workspace directory
ENV WORKSPACE_DIRECTORY="/mnt/workspace"
# Set default editor to vim
ENV EDITOR="vim"
ENV VISUAL="vim"
ENV LC_ALL="C.UTF-8"
