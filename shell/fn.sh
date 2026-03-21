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

function open-gh() {
    local remote_url
    remote_url=$(git remote get-url origin 2>/dev/null)
    if [ -z "$remote_url" ]; then
        echo "error: no git remote 'origin' found"
        return 1
    fi
    # Normalize SSH and HTTPS URLs to a browser URL
    local browser_url
    browser_url=$(echo "$remote_url" \
        | sed 's|git@github.com:|https://github.com/|' \
        | sed 's|\.git$||')
    if [[ "$browser_url" != *"github.com"* ]]; then
        echo "error: remote is not a GitHub URL: $remote_url"
        return 1
    fi
    open "$browser_url"
}

