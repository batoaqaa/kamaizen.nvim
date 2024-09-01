#!/bin/bash

set -e
# Function to detect the operating system and architecture
detect_os_arch() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     os=linux;;
        Darwin*)    os=macos;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*) os=windows;;  # For general Windows, WSL is detected as Linux
        *)          os="UNKNOWN:${unameOut}"
    esac

    archOut="$(uname -m)"
    case "${archOut}" in
        x86_64) arch=amd64;;
        arm64)  arch=arm64;;
        *)      arch="UNKNOWN:${archOut}"
    esac

    echo "${os}-${arch}"
}

# Function to set up installation directory
setup_install_dir() {
    INSTALL_DIR="$HOME/.local/bin"
    if [ "$os" == "macos" ]; then
        INSTALL_DIR="/usr/local/bin"
    fi

    # Check if the directory exists; if not, create it
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating install directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi

    echo "$INSTALL_DIR"
}

download_and_extract_kamaizen() {
    local version=$1
    local os_arch=$2
    local install_dir=$3

    url="https://github.com/IbrahimShahzad/KamaiZen/releases/download/$version/KamaiZen-$os_arch.tar.gz"

    echo "Downloading KamaiZen from $url..."
    curl -L -o "/tmp/KamaiZen.tar.gz" "$url" || {
        echo "Failed to download KamaiZen"
        exit 1
    }

    echo "Extracting KamaiZen..."
    tar -xzvf "/tmp/KamaiZen.tar.gz" -C "$install_dir" || {
        echo "Failed to extract KamaiZen"
        exit 1
    }

    chmod +x "$install_dir/KamaiZen"
}

VERSION="v0.0.1"

os_arch=$(detect_os_arch)
if [[ "$os_arch" == "UNKNOWN"* ]]; then
    echo "Unsupported OS or architecture: $os_arch"
    exit 1
fi

INSTALL_DIR=$(setup_install_dir)

download_and_extract_kamaizen "$VERSION" "$os_arch" "$INSTALL_DIR"

# Add installation directory to PATH if it's not already there
if ! grep -q "$INSTALL_DIR" <<< "$PATH"; then
    echo "Adding $INSTALL_DIR to PATH"
    if [ "$os" == "macos" ]; then
        echo 'export PATH="$PATH:'"$INSTALL_DIR"'"' >> "$HOME/.zshrc"
        export PATH="$PATH:$INSTALL_DIR"
    else
        echo 'export PATH="$PATH:'"$INSTALL_DIR"'"' >> "$HOME/.bashrc"
        export PATH="$PATH:$INSTALL_DIR"
    fi
fi

# Check if the installation was successful
if command -v KamaiZen &> /dev/null; then
    echo "KamaiZen installed successfully!"
else
    echo "Installation failed."
    exit 1
fi
