# ==========================================
# ZSHENV — environment variables & PATH
# ==========================================

# Add ~/bin to PATH early
export PATH="$HOME/bin:$PATH"

# ASDF
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$PATH:$ASDF_DATA_DIR/bin:$ASDF_DATA_DIR/shims"

# Node / nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="$PATH:$HOME/.local/bin"

# .NET
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# Default browser
export BROWSER="/usr/bin/firefox/bin"

# LS colors tweak
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
