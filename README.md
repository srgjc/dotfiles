# Dotfiles

Personal configuration files structured to be used with GNU Stow. (See: https://www.gnu.org/software/stow/)

In order to apply the configuration for a given program, execute the following command from the root project directory or the operating system subfolder:
```
stow -t ~/ <config-dir>/
```
## ZSH custom config

To load zsh custom configs, stow them first and then append the following to the .zshrc:
```
for file in ~/.config/zsh/*.zsh; do
  source "$file"
done
```
