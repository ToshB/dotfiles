# dotfiles

macOS terminal setup: Ghostty + zsh + starship.

## New machine

```sh
git clone <this-repo> ~/dotfiles
~/dotfiles/bootstrap.sh
```

The script installs Homebrew if missing, installs everything in `Brewfile`,
and symlinks the configs into `$HOME`. It is safe to re-run — correct symlinks
are left alone and anything real it would overwrite is backed up first.

Open a new terminal afterwards, or `exec zsh`.

## Layout

| Repo path | Links to |
|---|---|
| `zsh/zshrc` | `~/.zshrc` |
| `zsh/zprofile` | `~/.zprofile` |
| `config/starship.toml` | `~/.config/starship.toml` |
| `config/ghostty/config` | `~/.config/ghostty/config` |

Files live here and are symlinked out, so editing `~/.zshrc` edits the repo
and `git status` picks it up.

## What's in it

- **Ghostty** — terminal. Catppuccin Mocha, JetBrainsMono Nerd Font,
  `cmd+\`` quick-terminal (needs Accessibility permission for the global hotkey).
- **starship** — prompt, catppuccin-powerline preset.
- **zoxide** — replaces `cd` with a frecency-ranked version. `cdi` to pick
  interactively. Plain `cd /path` behaves normally.
- **fzf** — `ctrl-r` history, `ctrl-t` files, `alt-c` cd. Tab completion is
  unchanged; type `**` before Tab for the fuzzy version.
- **zsh-autosuggestions** — ghost text from history, → to accept.
- **zsh-syntax-highlighting** — must stay last in `.zshrc`.

## Notes

- `.zprofile` runs for login shells only, so `.zshrc` has a guarded
  `brew shellenv` for non-login interactive shells.
- Adding a package: install it, then `brew bundle dump --force --file=Brewfile`.
- Adding a config: put it in the repo and add a line to `LINKS` in `bootstrap.sh`.
