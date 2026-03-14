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

## tmux-gruvbox Plugin Notes

The gruvbox plugin is forked at `/Users/tristanbarrow/Projects/tmux-gruvbox` and symlinked into `~/.tmux/plugins/tmux-gruvbox`. The plugin is re-run after TPM in `tmux.conf` to ensure overrides apply correctly:

```
run '~/.tmux/plugins/tpm/tpm'
run '~/.tmux/plugins/tmux-gruvbox/gruvbox-tpm.tmux'
```

**Powerline arrows** — The `\ue0b0` (right-pointing) and `\ue0b2` (left-pointing) glyphs must be embedded as raw Unicode in `theme_gruvbox_dark.sh`. If arrows disappear after editing the theme, they were likely lost during a string replacement. They appear in:
- `status-left` — trailing `\ue0b0` after the session name block
- `window-status-format` / `window-status-current-format` — leading `\ue0b0` and trailing `\ue0b0` on each tab
- `status-right` loop — `\ue0b2` before each slot block

**Right status slots** — The plugin supports 8 configurable slots (`a`–`h`, left to right) set in `tmux.conf`:
```
set -g @tmux-gruvbox-right-status-a 'content'
set -g @tmux-gruvbox-right-color-a 'col_bg3'  # any palette variable name
```
Empty slots are skipped automatically. Color values are palette variable names from `palette_gruvbox_dark.sh` (e.g. `col_bg2`, `col_bg3`, `col_orange2`).
