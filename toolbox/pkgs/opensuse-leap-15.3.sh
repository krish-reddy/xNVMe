#!/bin/sh
# Query the linker version
ld -v || true

# Query the (g)libc version
ldd --version || true

zypper --non-interactive refresh

# Install packages via the system package-manager (zypper)
zypper --non-interactive install -y --allow-downgrade \
 autoconf \
 bash \
 clang-tools \
 cunit-devel \
 findutils \
 gcc \
 gcc-c++ \
 git \
 gzip \
 libaio-devel \
 libnuma-devel \
 libopenssl-devel \
 libtool \
 libuuid-devel \
 make \
 nasm \
 ncurses \
 patch \
 pkg-config \
 python3 \
 python3-devel \
 python3-pip \
 tar

# Clone, build and install liburing v2.2
git clone https://github.com/axboe/liburing.git
cd liburing
git checkout liburing-2.2
./configure --libdir=/usr/lib64 --libdevdir=/usr/lib64
make
make install

# Install packages via the Python package-manager (pip)
python3 -m pip install --upgrade pip
python3 -m pip install \
 pyelftools

# Install Python-based command-line tools via pipx
if ! pipx --help; then
        python3 -m pip install --upgrade pip
        python3 -m pip install pipx
        python3 -m pipx ensurepath
fi
python3 -m pipx install meson
python3 -m pipx install ninja

