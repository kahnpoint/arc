#!/bin/bash
# Setup symlinks for config files from arc repo to system locations

set -e

ARC_HOME="$HOME/arc"
ARC_CONFIG="$ARC_HOME/config"

# Create parent directories if they don't exist
mkdir -p ~/.config/helix/themes
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/karabiner

echo "Setting up symlinks..."

# Function to create symlink with backup
link() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    echo "  Removing existing symlink: $dest"
    rm "$dest"
  elif [ -f "$dest" ]; then
    echo "  Backing up existing file: $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -s "$src" "$dest"
  echo "  Linked: $dest -> $src"
}

# .zshrc
link "$ARC_HOME/.zshrc" "$HOME/.zshrc"

# Karabiner (goku config)
link "$ARC_CONFIG/karabiner.edn" "$HOME/.config/karabiner.edn"

# Aerospace
link "$ARC_CONFIG/aerospace.toml" "$HOME/.aerospace.toml"

# Helix
link "$ARC_CONFIG/helix.config.toml" "$HOME/.config/helix/config.toml"
link "$ARC_CONFIG/helix.languages.toml" "$HOME/.config/helix/languages.toml"
link "$ARC_CONFIG/helix.theme.toml" "$HOME/.config/helix/themes/arc.toml"

# Alacritty
link "$ARC_CONFIG/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

echo ""
echo "All symlinks created successfully!"
echo "Run 'source ~/.zshrc' to reload your shell config."
