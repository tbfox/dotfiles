function load_env() {
    if [ -z "$1" ]; then
        return 1
    fi
    
    if [ ! -f "$1" ]; then
        return 1
    fi
    
    source "$1"
}

function sc() { nvim -c "Sc go $1 $2"; }

