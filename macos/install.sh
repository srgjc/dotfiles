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

echo "Changing Mac OS Settings..."
defaults write com.apple.dock autohide -bool true

echo "Installation complete!"

