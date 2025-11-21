#/usr/bin/bash

# Symlink configs
stow alacritty
stow zsh
stow nvim
stow tmux

# Symlink scripts and binaries
stow -t ~ bin
