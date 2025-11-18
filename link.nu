[tmux shell ohmyposh ghostty]
| each {|linkable|
    let from = $'($env.HOME)/dotfiles/($linkable)'
    let to = $'($env.HOME)/.config/($linkable)'
    if ($to | path exists) {
        print $"Directory ($to) already exists."
    } else {
        ln -s $from $to
    }
}

