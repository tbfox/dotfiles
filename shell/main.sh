source ~/.config/shell/fn.sh
source ~/.config/shell/path.sh
source ~/.config/shell/alias.sh

load_env ~/.env
load_env ~/.private.env
load_env ~/.config/shell/.env

if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/gruvbox.omp.json)"
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
elif [ -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]; then
    . "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
fi
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

HSS_PLUGIN=~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
if [ -f "$HSS_PLUGIN" ]; then
    source "$HSS_PLUGIN"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
