load_env() {
    if [ -z "$1" ]; then
        return 1
    fi
    
    if [ ! -f "$1" ]; then
        return 1
    fi
    
    source "$1"
}

export EDITOR=nvim

load_env ~/.env
load_env ~/.private.env
load_env ~/.config/shell/env

source ~/.config/shell/path.sh
source ~/.config/shell/alias.sh

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/gruvbox.omp.json)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
