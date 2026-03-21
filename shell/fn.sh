function load_env() {
    if [ -z "$1" ]; then
        return 1
    fi
    
    if [ ! -f "$1" ]; then
        return 1
    fi
    
    source "$1"
}

function inturupting_cow() {
    trap '' SIGINT
    fortune | cowsay | lolcat -a
    trap - SIGINT
}

function sc() { nvim -c "Sc go $1 $2"; }

function clone() { git clone "https://github.com/$1/$2.git"; }

