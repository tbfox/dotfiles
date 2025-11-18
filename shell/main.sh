load_env() {
    if [ -z "$1" ]; then
        return 1
    fi
    
    if [ ! -f "$1" ]; then
        return 1
    fi
    
    source "$1"
}

load_env ~/.env
load_env ~/.private.env
load_env ~/.config/shell/env

source ~/.config/shell/path.sh
source ~/.config/shell/alias.sh

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/gruvbox.omp.json)"
eval "$(zoxide init zsh)"
