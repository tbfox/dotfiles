source ~/.config/shell/fn.sh
source ~/.config/shell/path.sh
source ~/.config/shell/alias.sh

load_env ~/.env
load_env ~/.private.env
load_env ~/.config/shell/.env

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/gruvbox.omp.json)"
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
elif [ -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]; then
    . "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
fi
source <(fzf --${SHELL##*/})

autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
