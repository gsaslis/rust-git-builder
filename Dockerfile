FROM ubuntu:22.04

# install latest git (2.40.1)
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && apt-add-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get install -y git curl gcc tree jq sqlite3 make \
  && git --version

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain=1.85.0 -y \
  && . "$HOME/.cargo/env" \
  && cargo --version