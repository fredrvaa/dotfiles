#!/usr/bin/env bash

# Stow dotfiles
echo "Stowing dotfiles..."
stow alacritty
stow ghostty
stow zsh
stow nvim
stow tmux
stow hypr
stow rofi

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

# Install ohmyzsh
if [ ! -d $HOME/.oh-my-zsh/ ]; then
	echo "Installing ohmyzsh..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "ohmyzsh already installed"
fi

# Ensure ZSH paths exist
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install zsh plugins
echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" || true

git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git \
  "$ZSH_CUSTOM/plugins/zsh-autocomplete" || true
