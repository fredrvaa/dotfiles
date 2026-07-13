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
stow waybar
stow yazi

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
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing ohmyzsh..."
	git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
else
	echo "ohmyzsh already installed"
fi

# Ensure ZSH paths exist
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install zsh plugins if missing
echo "Installing zsh plugins..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
else
  echo "fast-syntax-highlighting already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git \
    "$ZSH_CUSTOM/plugins/zsh-autocomplete"
else
  echo "zsh-autocomplete already installed."
fi

# Install Neovim (tarball -> ~/.local/share, matches the PATH set in zsh/.zshrc).
# Note: nvim-treesitter needs a C compiler (base-devel on Arch, build-essential on Debian/Ubuntu).
NVIM_DIR="$HOME/.local/share/nvim-linux-x86_64"
if [ ! -x "$NVIM_DIR/bin/nvim" ]; then
  echo "Installing Neovim..."
  mkdir -p "$HOME/.local/share"
  nvim_tmp="$(mktemp -d)"
  curl -fsSL -o "$nvim_tmp/nvim.tar.gz" \
    https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
  tar -xzf "$nvim_tmp/nvim.tar.gz" -C "$HOME/.local/share"
  rm -rf "$nvim_tmp"
else
  echo "Neovim already installed."
fi

# Install nvm + Node LTS (Mason LSP servers install via npm)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "Installing nvm..."
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  ( cd "$NVM_DIR" && git checkout "$(git describe --tags "$(git rev-list --tags --max-count=1)")" )
else
  echo "nvm already installed."
fi
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"
if ! command -v node >/dev/null 2>&1; then
  echo "Installing Node LTS..."
  nvm install --lts
  nvm alias default 'lts/*'
else
  echo "Node already installed."
fi
