# See here for image contents: https://github.com/devcontainers/images/blob/main/src/rust/.devcontainer/Dockerfile

# [Choice] Debian OS version (use bookworm, or bullseye on local arm64/Apple Silicon): bookworm, buster, bullseye
ARG VARIANT="bookworm"
FROM mcr.microsoft.com/devcontainers/rust:1-${VARIANT}

ENV RUSTUP_HOME=/home/vscode/.rustup
ENV CARGO_HOME=/home/vscode/.cargo

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
	clang \
	ca-certificates \
	git \
    build-essential \
    cmake \
    unzip \
    ninja-build \
    gettext \
    curl

# Install the latest neovim
RUN curl -fSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz -o nvim-linux-arm64.tar.gz \
    && mkdir -p /home/vscode/.local/share/ \
    && tar xzvf nvim-linux-arm64.tar.gz -C /home/vscode/.local/share/ \
	&& mkdir -p /home/vscode/.local/bin/ \
    && ln -sf /home/vscode/.local/share/nvim-linux-arm64/bin/nvim /home/vscode/.local/bin/nvim

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/vscode/.fzf

RUN chown -R vscode:vscode /home/vscode /usr/local /tmp /var/tmp /opt
