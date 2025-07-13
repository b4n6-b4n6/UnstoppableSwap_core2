FROM debian:12

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR="/root/.nvm"
ENV PATH="/root/.nvm/versions/node/v20.18.0/bin:/root/.cargo/bin:$PATH"
ENV RUST_VERSION=stable

# Update package lists and install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libssl-dev \
    libzmq3-dev \
    libunbound-dev \
    libsodium-dev \
    libunwind8-dev \
    liblzma-dev \
    libreadline6-dev \
    libexpat1-dev \
    libpgm-dev \
    qttools5-dev-tools \
    libhidapi-dev \
    libusb-1.0-0-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libudev-dev \
    libboost-chrono-dev \
    libboost-date-time-dev \
    libboost-filesystem-dev \
    libboost-locale-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-serialization-dev \
    libboost-system-dev \
    libboost-thread-dev \
    python3 \
    ccache \
    doxygen \
    graphviz \
    curl \
    git \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    libwebkit2gtk-4.0-dev \
    libjavascriptcoregtk-4.0-dev \
    gir1.2-webkit2-4.0 \
    gir1.2-javascriptcoregtk-4.0  \
    libsoup-3.0-dev \
    fakeroot \
    dpkg-dev \
    libjavascriptcoregtk-4.1-dev \
    libwebkit2gtk-4.1-dev \
    libabsl-dev \
    libnghttp2-dev \
    libevent-dev \
    libboost-all-dev \
    miniupnpc \
    nettle-dev \
    && rm -rf /var/lib/apt/lists/*

# Install NVM and Node.js LTS
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install --lts \
    && nvm use --lts \
    && npm install -g yarn

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && . "$HOME/.cargo/env" \
    && rustc --version

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/Justxd22/UnstoppableSwap_core2

# Change to the cloned directory
WORKDIR /app/UnstoppableSwap_core2

# Initialize and update submodules
RUN git submodule update --init --recursive

# Install required Rust tools
RUN . "$HOME/.cargo/env" \
    && cargo install typeshare-cli dprint \
    && cargo install tauri-cli@2.1.0 --locked

# Build the project
RUN . "$HOME/.cargo/env" \
    && . "$NVM_DIR/nvm.sh" \
    && cargo tauri build

RUN mkdir -p /output \
    && cp -r target/release/bundle/deb /output/ \
    && cp -r target/release/bundle/appimage /output/ \
    && ls -la /output/

# Set the default command
CMD ["bash"]