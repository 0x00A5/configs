FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Create your own user
ARG USERNAME=yuan
ARG USER_UID=1001
ARG USER_GID=1001

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /usr/bin/fish \
    && apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        clang \
        cmake \
        unzip \
        ninja-build \
        gettext \
        curl \
        git \
        fish \
        ripgrep \
        stow \
        protobuf-compiler \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

# ---------------------
# Rust (stable + nightly)
# ---------------------
ENV RUSTUP_HOME=/home/${USERNAME}/.rustup
ENV CARGO_HOME=/home/${USERNAME}/.cargo
ENV PATH=${CARGO_HOME}/bin:${PATH}

RUN mkdir -p ${RUSTUP_HOME} ${CARGO_HOME} \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Install rustup, stable & nightly, with components
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && rustup toolchain install stable nightly-2025-08-01 \
    && rustup component add rustfmt clippy rust-analyzer --toolchain stable \
    && rustup component add rustfmt clippy rust-analyzer --toolchain nightly-2025-08-01

# ---------------------
# Neovim (latest release)
# ---------------------
RUN curl -fSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz -o nvim-linux-arm64.tar.gz \
    && mkdir -p /home/${USERNAME}/.local/share/ \
    && tar xzvf nvim-linux-arm64.tar.gz -C /home/${USERNAME}/.local/share/ \
	&& mkdir -p /home/${USERNAME}/.local/bin/ \
    && ln -sf /home/${USERNAME}/.local/share/nvim-linux-arm64/bin/nvim /home/${USERNAME}/.local/bin/nvim

# ---------------------
# fzf (for your ~/.fzf setup)
# ---------------------
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# Make sure your local bin is on PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

