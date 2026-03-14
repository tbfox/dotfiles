# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

This is a dotfiles repository. To apply the configuration, run the linking script with Nushell:

```sh
nu link.nu
```

This creates symlinks from `~/dotfiles/<tool>` to `~/.config/<tool>` for: `tmux`, `shell`, `ohmyposh`, and `ghostty`.

## Architecture

The repo is organized into per-tool directories. Each directory maps directly to a `~/.config/<tool>` symlink.

- **`shell/`** — Zsh config split across `zprofile` (Homebrew init), `main.sh` (editor, env loading, oh-my-posh, zoxide, fzf), `path.sh` (PATH extensions), `alias.sh` (aliases), and `.env` (project-specific env vars)
- **`tmux/`** — Tmux config split into focused files: `tmux.conf` (main, loads the rest), `statusbar.tmux`, `copy-mode.tmux` (vi bindings + pbcopy), `nvim-navigator.tmux` (Ctrl+hjkl pane switching that detects nvim), `new-pane-current-path.tmux`
- **`ohmyposh/`** — Two themes: `gruvbox.omp.json` (standard, currently active) and `claude.omp.json` (shows Claude model, token usage, and cost — used with Claude CLI)
- **`ghostty/`** — Ghostty terminal config (Gruvbox Dark Hard theme)
- **`scripts/`** — Nushell utility scripts (`slack.nu` for Slack list management, `prag.nu` for open-practices templates)

## Key Conventions

- **Prefix key**: `Ctrl+Space` (tmux)
- **Theme**: Gruvbox Dark across all tools
- **Editor**: `nvim` (aliased from `vim`)
- **Pane navigation**: `Ctrl+hjkl` shared between tmux and neovim via `nvim-navigator.tmux`
- **Scripts**: Utility scripts use Nushell (`.nu`) rather than bash
- **Private config**: `shell/.env` and `shell/.private.env` are sourced at shell startup but not committed
