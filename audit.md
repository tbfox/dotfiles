# Dotfiles Audit

## Critical

**1. Undefined function `inturupting_cow`** (`shell/alias.sh:6`)
`alias vim.=inturupting_cow` — the function is never defined anywhere. Running `vim.` will error.

**2. Token variable mismatch** (`scripts/slack.nu`)
Uses `$env.SLACK_TOKEN_USER` for the Authorization header but checks `$env.SLACK_TOKEN?` for validation. One of these is wrong.

---

## High

**3. Wrong script name in docs** (`CLAUDE.md:7`)
References `nu link.nu` but the actual script is `install.nu`.

**4. Unguarded fzf init** (`shell/main.sh:15`)
`source <(fzf --${SHELL##*/})` — no existence check. zoxide on line 10 has one but fzf doesn't. Fails if fzf isn't installed.

**5. install.nu assumes `$HOME/dotfiles`** (`install.nu:56`)
`let from = $'($env.HOME)/dotfiles/($linkable)'` — breaks if repo is cloned elsewhere. Should use the script's own directory instead.

---

## Medium

**6. Redundant `pane-base-index`** (`tmux/windows.tmux:2-3`)
Set twice — once with `set -g` and again with `set-window-option -g`.

**7. `$HOMEBREW_PREFIX` may be unset** (`shell/main.sh:12`)
If `main.sh` is sourced before `zprofile`, the variable won't exist. Shouldn't cause issues in practice but is fragile.

**8. Hardcoded absolute path** (`shell/.env:1`)
`/Users/tristanbarrow/Data/hours` — use `$HOME` for portability.

---

## Low / Style

**9. Trailing whitespace** (`ghostty/config:1`)
`theme = Gruvbox Dark Hard ` has a trailing space.

**10. Commented template code** (`shell/path.sh:1`)
Leftover `# export PATH="$PATH:~/path/to/your/directory"`.

**12. `oh-my-posh` tap conflict** (`install.nu:2`) ✓ Fixed
Package list used `oh-my-posh` (homebrew/core) but it's installed from `jandedobbeleer/oh-my-posh` tap. Changed to fully-qualified `jandedobbeleer/oh-my-posh/oh-my-posh`.

**11. Hardcoded Slack list IDs** (`scripts/slack.nu:23-24`)
Workspace-specific IDs committed to repo. Fine for a private repo, risky if ever made public.
