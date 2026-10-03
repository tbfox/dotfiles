#!/usr/bin/env bash
set -euo pipefail

PACKAGES_BREW="jandedobbeleer/oh-my-posh/oh-my-posh zoxide fzf neovim fortune cowsay lolcat"
PACKAGES_APT="fzf fortune cowsay lolcat zoxide"

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Install it from https://brew.sh"
        exit 1
    fi
    for pkg in $PACKAGES_BREW; do
        brew install "$pkg"
    done
    brew install z
elif [[ "$OS" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
        sudo apt-get update
        # neovim from apt is often outdated — use snap for latest stable
        sudo apt-get install -y $PACKAGES_APT
        sudo snap install --classic nvim
        sudo snap install oh-my-posh
        # z has no apt package — install manually
        Z_DEST="$HOME/.local/bin/z.sh"
        if [[ ! -f "$Z_DEST" ]]; then
            curl -fsSL https://raw.githubusercontent.com/rupa/z/master/z.sh -o "$Z_DEST"
        fi
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --needed --noconfirm zsh tmux fzf fortune-mod cowsay lolcat zoxide neovim lsof wl-clipboard
        if command -v yay &>/dev/null; then
            yay -S --needed --noconfirm oh-my-posh-bin
        else
            echo "yay not found — install oh-my-posh-bin from the AUR manually"
        fi
    else
        echo "Unsupported package manager. Install packages manually."
        exit 1
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# zsh-history-substring-search
PLUGIN_DEST="$HOME/.config/zsh/plugins/zsh-history-substring-search"
if [[ ! -d "$PLUGIN_DEST" ]]; then
    echo "Cloning zsh-history-substring-search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search "$PLUGIN_DEST"
fi

# Symlinks
echo "Linking dotfiles..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for linkable in tmux shell ohmyposh ghostty pi; do
    from="$SCRIPT_DIR/$linkable"
    link_file="$from/.link"
    if [[ -f "$link_file" ]]; then
        to="$(eval echo "$(cat "$link_file" | tr -d '[:space:]')")"
    else
        to="$HOME/.config/$linkable"
    fi
    if [[ -e "$to" ]]; then
        echo "Already exists: $to"
    else
        ln -s "$from" "$to"
        echo "Linked $linkable -> $to"
    fi
done

# tmux plugins: TPM + gruvbox fork (symlinked from ~/Projects so it can be edited)
TPM_DEST="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DEST" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DEST"
fi
GRUVBOX_SRC="$HOME/Projects/tmux-gruvbox"
if [[ ! -d "$GRUVBOX_SRC" ]]; then
    git clone https://github.com/tbfox/tmux-gruvbox "$GRUVBOX_SRC"
fi
GRUVBOX_DEST="$HOME/.tmux/plugins/tmux-gruvbox"
if [[ ! -e "$GRUVBOX_DEST" ]]; then
    ln -s "$GRUVBOX_SRC" "$GRUVBOX_DEST"
fi

# zsh entry points
if [[ ! -e "$HOME/.zprofile" ]]; then
    echo 'source ~/.config/shell/zprofile' > "$HOME/.zprofile"
    echo "Created ~/.zprofile"
fi
if [[ ! -e "$HOME/.zshrc" ]]; then
    echo 'source ~/.config/shell/main.sh' > "$HOME/.zshrc"
    echo "Created ~/.zshrc"
fi
ZSH_PATH="$(command -v zsh || true)"
if [[ -n "$ZSH_PATH" && "${SHELL:-}" != "$ZSH_PATH" ]]; then
    echo "Changing login shell to $ZSH_PATH..."
    chsh -s "$ZSH_PATH"
fi

echo "Done."
