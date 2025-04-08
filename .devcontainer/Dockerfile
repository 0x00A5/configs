# See here for image contents: https://github.com/devcontainers/images/blob/main/src/rust/.devcontainer/Dockerfile

# [Choice] Debian OS version (use bookworm, or bullseye on local arm64/Apple Silicon): bookworm, buster, bullseye
ARG VARIANT="buster"
FROM mcr.microsoft.com/devcontainers/rust:1-${VARIANT}

RUN apt-get update && apt-get install -y stow clang fish neovim
RUN curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
RUN fish -c "omf install bobthefish"
