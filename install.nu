let packages = [
    oh-my-posh
    zoxide
    fzf
    neovim
    fortune
    cowsay
    lolcat
]

let os = $nu.os-info.name

if $os == "macos" {
    if (which brew | is-empty) {
        print "Homebrew not found. Install it from https://brew.sh"
        exit 1
    }
    $packages | each {|pkg| ^brew install $pkg }
    ^brew install z
} else if $os == "linux" {
    if not (which apt-get | is-empty) {
        ^sudo apt-get update
        # neovim from apt is often outdated — use snap for latest stable
        ^sudo apt-get install -y fzf fortune cowsay lolcat zoxide
        ^sudo snap install --classic nvim
        ^sudo snap install oh-my-posh
        # z has no apt package — install manually
        let z_dest = ($env.HOME | path join ".local/bin/z.sh")
        if not ($z_dest | path exists) {
            ^curl -fsSL https://raw.githubusercontent.com/rupa/z/master/z.sh -o $z_dest
        }
    } else if not (which pacman | is-empty) {
        ^sudo pacman -Sy --noconfirm fzf fortune-mod cowsay zoxide neovim
        # oh-my-posh and lolcat via AUR or manual
        print "Install oh-my-posh and lolcat manually or via AUR"
    } else {
        print "Unsupported package manager. Install packages manually."
        exit 1
    }
} else {
    print $"Unsupported OS: ($os)"
    exit 1
}

# zsh-history-substring-search
let plugin_dest = ($env.HOME | path join ".config/zsh/plugins/zsh-history-substring-search")
if not ($plugin_dest | path exists) {
    print "Cloning zsh-history-substring-search..."
    ^git clone https://github.com/zsh-users/zsh-history-substring-search $plugin_dest
}

# Symlinks
print "Linking dotfiles..."
[tmux shell ohmyposh ghostty]
| each {|linkable|
    let from = $'($env.HOME)/dotfiles/($linkable)'
    let to = $'($env.HOME)/.config/($linkable)'
    if ($to | path exists) {
        print $"Already exists: ($to)"
    } else {
        ln -s $from $to
        print $"Linked ($linkable)"
    }
}

print "Done."
