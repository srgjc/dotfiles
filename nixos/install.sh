#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"
NIXOS_DIR="/etc/nixos"

mkdir -p "$CONFIG_DIR"

NIX_FILES=(
  "configuration.nix"
  "flake.nix"
  "flake.lock"
  "hardware-configuration.nix"
)

# Directories from dotfiles/config/ -> ~/.config/
CONFIG_FOLDERS=(
)

# Files from dotfiles/home/ -> ~/
HOME_FILES=(
)

link_item() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  # Already linked correctly
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✓ $dest"
    return
  fi

  # Existing file, directory, or incorrect symlink
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="${dest}.bak.$(date +%Y%m%d-%H%M%S)"
    echo "Backing up $dest -> $backup"
    mv "$dest" "$backup"
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

echo "Linking config entries..."
for folder in "${CONFIG_FOLDERS[@]}"; do
  link_item \
    "$DOTFILES_DIR/config/$folder" \
    "$CONFIG_DIR/$folder"
done

echo
echo "Linking home dotfiles..."
for file in "${HOME_FILES[@]}"; do
  link_item \
    "$DOTFILES_DIR/home/$file" \
    "$HOME/.$file"
done

echo "Linking nix dotfiles..."
for file in "${NIX_FILES[@]}"; do
  link_item \
    "$DOTFILES_DIR/system/$file" \
    "$NIXOS_DIR/$file"
done

echo
echo "Done."
