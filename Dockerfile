FROM ubuntu:22.04

# install latest git (2.40.1)
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && apt-add-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get install -y git curl gcc tree jq sqlite3 make \
  && git --version

# installs subplot - https://subplot.tech/download/
RUN tmp="$(mktemp)" \
  && curl http://apt.liw.fi/debian/pool/main/a/apt.liw.fi-keyring/apt.liw.fi-keyring_1.5-1_all.deb >"$tmp" \
  && dpkg -i "$tmp" \
  && rm -f "$tmp" \
  && echo "deb [signed-by=/usr/share/keyrings/apt.liw.fi-keyring.pgp] http://apt.liw.fi/debian unstable main" > /etc/apt/sources.list.d/subplot.list \
  && apt-get update \
  && apt-get install --assume-yes --no-remove subplot

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain=1.88.0 -y \
  && . "$HOME/.cargo/env" \
  && cargo --version

RUN curl -LsSf https://get.nexte.st/latest/linux-musl | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin