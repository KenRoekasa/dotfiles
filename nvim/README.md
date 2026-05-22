# Neovim Configuration

LazyVim-based setup focused on C/C++ development with CMake, debugging, and AI assistance.

## External Dependencies

Install these system packages before launching Neovim:

### Required

| Package | Purpose | Min Version |
|---------|---------|-------------|
| **neovim** | Editor | 0.11+ |
| **git** | Plugin manager, lazygit | 2.19+ |
| **gcc** / **g++** | Build treesitter parsers | any |
| **make** | Build treesitter parsers | any |
| **curl** | Plugin downloads (blink.cmp, Mason) | any |
| **node** + **npm** | markdown-preview, some LSP servers | 18+ |

### Highly Recommended

| Package | Purpose |
|---------|---------|
| **ripgrep** (`rg`) | Live grep, fzf-lua search |
| **fd** (`fd-find`) | Fast file finding (fzf-lua) |
| **fzf** | Fuzzy finder backend |
| **lazygit** | Git UI (`<leader>gg`) |
| **tree-sitter** CLI | Treesitter parser compilation |
| **clang-format** | C/C++ formatting |
| **cmake** | CMake project builds |

### Optional

| Package | Purpose |
|---------|---------|
| **codelldb** | C/C++ debug adapter (installed via Mason) |
| **gdb** 14+ | Alternative debug adapter (DAP mode) |
| **stylua** | Lua formatting (installed via Mason) |
| **python3** + **pip** | Some LSP servers |
| **Nerd Font** v3+ | Icons in file tree, statusline, etc. |

### Install Commands

**Fedora / Rocky Linux:**
```bash
sudo dnf install neovim git gcc g++ make curl nodejs npm ripgrep fd-find fzf cmake clang-tools-extra tree-sitter-cli
# lazygit (from COPR or GitHub releases)
sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit
```

**Ubuntu / Debian:**
```bash
sudo apt install neovim git gcc g++ make curl nodejs npm ripgrep fd-find fzf cmake clang-format
# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin/
```

**macOS (Homebrew):**
```bash
brew install neovim git ripgrep fd fzf lazygit node cmake clang-format tree-sitter
```

## Setup

```bash
# Symlink config
ln -sfn ~/dotfiles/nvim/.config/nvim ~/.config/nvim

# Clear any old Neovim data
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Launch — lazy.nvim bootstraps everything
nvim
```

On first launch, all plugins will auto-install. Wait for it to finish, then restart Neovim.

## Plugin Structure

```
lua/plugins/
├── ai.lua         → Copilot + Claude Code
├── clangd.lua     → clangd LSP flags
├── cmake.lua      → cmake-tools config + keybinds
├── dap.lua        → GDB adapter + virtual text
├── editor.lua     → flash, surround, multicursor, oil, grug-far, toggleterm
├── git.lua        → diffview
├── ide-feel.lua   → dropbar, lightbulb, scrollbar, symbol-usage, ufo, bqf, dressing, indent
├── markdown.lua   → render-markdown + preview
├── test.lua       → neotest + ctest
└── ui.lua         → noice, fidget, inlay hints
```

## LazyVim Extras Enabled

These are loaded via `lua/config/lazy.lua`:

- `lang.clangd` — clangd + clangd_extensions + codelldb
- `lang.cmake` — cmake-tools + neocmake LSP
- `dap.core` — nvim-dap + dap-ui + Mason DAP
- `editor.aerial` — Structure panel (symbol outline)
- `editor.inc-rename` — In-place rename preview
- `editor.fzf` — fzf-lua as the fuzzy finder
- `ui.edgy` — Docked side panels (neo-tree, aerial, trouble, dap-ui)
- `ui.treesitter-context` — Sticky function headers

## See Also

- [KEYBINDINGS.md](KEYBINDINGS.md) — Full keybinding reference
- [migration.md](migration.md) — Detailed migration guide from NvChad
