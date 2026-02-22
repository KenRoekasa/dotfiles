# Dotfiles

## Installation

### 1. Stow packages

From `~/dotfiles`:

```bash
cd ~/dotfiles && stow tmux nvim
```

This creates the following symlinks:

- `~/.tmux.conf` → `dotfiles/tmux/.tmux.conf`
- `~/.config/nvim/` → `dotfiles/nvim/.config/nvim/`
- `~/.stylua.toml` → `dotfiles/nvim/.stylua.toml`

### 2. Tmux

Install TPM (Tmux Plugin Manager):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Source the config and install plugins:

```bash
tmux source-file ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
```

Or from inside tmux, press `prefix + I` to install plugins.

### 3. Neovim

Install vim plugins (handled automatically by lazy.nvim on first launch).
