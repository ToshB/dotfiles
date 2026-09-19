#!/usr/bin/env bash
# Set up a fresh macOS machine from this repo.
#   git clone <repo> ~/dotfiles && ~/dotfiles/bootstrap.sh
# Safe to re-run: existing correct symlinks are left alone, and anything
# real that would be overwritten is backed up to <file>.backup-<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m==>\033[0m %s\n' "$1"; }

# ---------- homebrew ----------
if ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    info "Installing Homebrew (will prompt for your password)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

info "Installing packages from Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

# ---------- symlinks ----------
# repo path : path relative to $HOME
LINKS=(
  "zsh/zshenv:.zshenv"
  "zsh/zshrc:.zshrc"
  "zsh/zprofile:.zprofile"
  "git/gitconfig:.gitconfig"
  "git/gitconfig-nrk:.gitconfig-nrk"
  "config/starship.toml:.config/starship.toml"
  "config/ghostty/config:.config/ghostty/config"
)

info "Linking dotfiles"
for entry in "${LINKS[@]}"; do
  src="$DOTFILES/${entry%%:*}"
  dst="$HOME/${entry##*:}"

  if [ ! -e "$src" ]; then
    warn "missing in repo, skipping: ${entry%%:*}"
    continue
  fi

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  ok       ${entry##*:}"
    continue
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$dst.backup-$STAMP"
    echo "  backed up ${entry##*:} -> ${entry##*:}.backup-$STAMP"
  fi

  ln -s "$src" "$dst"
  echo "  linked   ${entry##*:}"
done

info "Done. Open a new terminal, or run: exec zsh"
