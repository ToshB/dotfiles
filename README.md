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
| `zsh/zshenv` | `~/.zshenv` |
| `zsh/zshrc` | `~/.zshrc` |
| `zsh/zprofile` | `~/.zprofile` |
| `git/gitconfig` | `~/.gitconfig` |
| `git/gitconfig-nrk` | `~/.gitconfig-nrk` |
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

## Not covered by bootstrap

[Vite+](https://viteplus.dev) manages node/npm/pnpm/yarn/bun and is installed
separately (it is not a Homebrew package):

```sh
curl -fsSL https://vite.plus | bash
```

The configs here already source its env file; run `vp env doctor` to verify.

## Git identity

Personal by default (`tosh@tosh.no`). Repos under `~/dev/nrk` use the NRK
address instead, via an `includeIf` in `.gitconfig`. Add another context by
creating `git/gitconfig-<name>` and adding an `includeIf` that points at it.

## Diffs

Kaleidoscope is configured as `diff.tool` and `merge.tool`, so `git difftool`
and `git mergetool` open it. Plain `git diff` is unchanged. The `ksdiff` CLI
comes from the cask.

## Notes

- `.zprofile` runs for login shells only, so `.zshrc` has a guarded
  `brew shellenv` for non-login interactive shells.
- Adding a package: install it, then `brew bundle dump --force --file=Brewfile`.
- Adding a config: put it in the repo and add a line to `LINKS` in `bootstrap.sh`.
