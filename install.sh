#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow tmux nvim wezterm bash

echo "==> Bootstrapping lazy.nvim..."
LAZYPATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy/lazy.nvim"
if [ ! -f "$LAZYPATH/lua/lazy/init.lua" ]; then
  git clone --filter=blob:none --branch=stable \
    https://github.com/folke/lazy.nvim.git "$LAZYPATH"
  echo "    lazy.nvim installed."
else
  echo "    lazy.nvim already installed, skipping."
fi

echo "==> Bootstrapping TPM (Tmux Plugin Manager)..."
TPM_PATH="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_PATH" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
  echo "    TPM installed."
else
  echo "    TPM already installed, skipping."
fi

echo ""
echo "Done! Next steps:"
echo "  - Open nvim — lazy.nvim will install all plugins on first launch"
echo "  - Run :Copilot auth in nvim to authenticate GitHub Copilot"
echo "  - Inside tmux, press prefix + I to install tmux plugins"
