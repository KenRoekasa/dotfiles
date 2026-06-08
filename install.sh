#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing system dependencies..."
sudo dnf install -y epel-release
sudo dnf remove -y nodejs npm 2>/dev/null || true
sudo dnf install -y stow git curl ripgrep neovim tmux nodejs npm

echo "==> Installing tree-sitter-cli..."
sudo npm install -g tree-sitter-cli

echo "==> Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow tmux nvim wezterm bash

echo "==> Installing latest fzf binary..."
FZF_LATEST=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
mkdir -p "$HOME/.local/bin"
curl -sL "https://github.com/junegunn/fzf/releases/download/${FZF_LATEST}/fzf-${FZF_LATEST#v}-linux_amd64.tar.gz" \
  | tar xz -C "$HOME/.local/bin"
echo "    fzf ${FZF_LATEST} installed."

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

echo "==> Installing vim-plug..."
PLUG_PATH="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_PATH" ]; then
  curl -fLo "$PLUG_PATH" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "    vim-plug installed."
else
  echo "    vim-plug already installed, skipping."
fi

echo ""
echo "Done! Next steps:"
echo "  - Open nvim — lazy.nvim will install all plugins on first launch"
echo "  - Run :checkhealth in nvim to verify everything is set up correctly"
echo "  - Run :Copilot auth in nvim to authenticate GitHub Copilot"
echo "  - Inside tmux, press prefix + I to install tmux plugins"
