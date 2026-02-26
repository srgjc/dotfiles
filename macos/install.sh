#!/bin/zsh

echo "Installing XCode CLI Tools..."
xcode-select --install

echo "Planting Dotfiles..."
# TODO

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

echo "Installing Homebrew Packages..."
brew bundle install

echo "Changing Shell to Fish..."
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
# TODO

echo "Starting Brew Services (Grant Permissions)..."
# brew services start borders

echo "Changing Mac OS Settings..."
defaults write com.apple.dock autohide -bool true

echo "Installation complete!"

