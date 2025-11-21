#/usr/bin/bash

# Stow dotfiles
echo "Stowing dotfiles..."
stow alacritty
stow zsh
stow nvim
stow tmux

# Stow scripts and binaries
echo "Stowing scripts and binaries..."
stow -t ~ bin

set -e

# Install TPM if not already installed
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "TPM already installed."
fi

# Install tmux plugins via TPM
echo "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins"

echo "Tmux plugins installed."
