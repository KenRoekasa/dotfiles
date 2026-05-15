# Dotfiles

## Packages

| Package | Description |
|---------|-------------|
| `nvim`  | Neovim config (NvChad, LSP, DAP, Copilot, etc.) |
| `tmux`  | Tmux config with TPM and Dracula theme |
| `wezterm` | WezTerm terminal config |
| `bash`  | Bash config |
| `vim`   | Vim config |

## Dependencies

Install these before running the install script:

```bash
sudo dnf install epel-release
sudo dnf install stow git curl ripgrep neovim tmux
```

## Installation

### 1. Run the install script

From `~/dotfiles`:

```bash
cd ~/dotfiles && ./install.sh
```

This will stow all packages and bootstrap lazy.nvim and TPM automatically.

Alternatively, stow manually:

```bash
cd ~/dotfiles && stow tmux nvim wezterm bash
```

This creates the following symlinks:

- `~/.tmux.conf` → `dotfiles/tmux/.tmux.conf`
- `~/.config/nvim/` → `dotfiles/nvim/.config/nvim/`
- `~/.stylua.toml` → `dotfiles/nvim/.stylua.toml`
- `~/.config/wezterm/` → `dotfiles/wezterm/.config/wezterm/`

### 2. WezTerm

Install via RPM (Rocky Linux 8):

```bash
curl -LO "https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.centos8.x86_64.rpm"
sudo dnf install ./wezterm-20240203_110809_5046fc22-1.centos8.x86_64.rpm
```

Or build from source:

```bash
# Dependencies
sudo dnf install epel-release && sudo dnf update -y
sudo dnf groupinstall "Development Tools"
sudo dnf install cmake freetype-devel fontconfig-devel libxcb-devel \
  libX11-devel libXcursor-devel libXrandr-devel libXi-devel \
  mesa-libGL-devel mesa-libEGL-devel harfbuzz-devel openssl-devel \
  dbus-devel xcb-util-devel xcb-util-wm-devel xcb-util-keysyms-devel \
  xcb-util-image-devel git curl

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Build
git clone --recursive https://github.com/wez/wezterm.git
cd wezterm && cargo build --release
sudo cp target/release/wezterm target/release/wezterm-gui target/release/wezterm-mux-server /usr/local/bin/
```

**WezTerm keybinds** (leader: `Ctrl+b`):

| Key | Action |
|-----|--------|
| `Ctrl+b %` | Split pane vertically |
| `Ctrl+b "` | Split pane horizontally |
| `Ctrl+b c` | New tab |
| `Ctrl+b n/p` | Next/prev tab |
| `Ctrl+b 1-9` | Go to tab |
| `Ctrl+b h/j/k/l` | Navigate panes |
| `Ctrl+b Ctrl+←↑↓→` | Resize panes |
| `Ctrl+b z` | Zoom/unzoom pane |
| `Ctrl+b Space` | Rotate panes |
| `Ctrl+b [` | Copy mode |
| `Ctrl+b ,` | Rename tab |

### 3. Tmux

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

### 4. Neovim

Plugins are handled automatically by lazy.nvim on first launch.

Run `:Copilot auth` on first launch to authenticate GitHub Copilot.

**Key nvim bindings:**

| Key | Action |
|-----|--------|
| `Ctrl+b` | Go to definition (CLion-style) |
| `Alt+Enter` | Code action / quick fix |
| `F4` | Go to source file (in diffview) |
| `F10` | Switch header/source |
| `Shift+F10` | Run nearest test |
| `Ctrl+Shift+F10` | Run file tests |
| `<leader>ac` | Toggle Claude Code |
| `<leader>gg` | Neogit status |
| `<leader>gh` | File history (diffview) |
