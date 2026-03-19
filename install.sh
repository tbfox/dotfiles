#!/bin/sh
set -e

# Install Nushell if not present
if ! command -v nu >/dev/null 2>&1; then
    echo "Installing Nushell..."
    if [ "$(uname)" = "Darwin" ]; then
        if ! command -v brew >/dev/null 2>&1; then
            echo "Homebrew not found. Install it from https://brew.sh"
            exit 1
        fi
        brew install nushell
    elif [ "$(uname)" = "Linux" ]; then
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install -y nushell
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm nushell
        else
            echo "Unsupported package manager. Install Nushell manually: https://www.nushell.sh"
            exit 1
        fi
    else
        echo "Unsupported OS. Install Nushell manually: https://www.nushell.sh"
        exit 1
    fi
fi

nu "$(dirname "$0")/install.nu"
