# Neovim Configuration

NvChad v2.5-based setup focused on C/C++ development with CMake, debugging, and AI assistance.

## Current Plugin Stack

| Category | Plugins |
|----------|---------|
| LSP | clangd, cmake, mason, nvim-lspconfig |
| Completion | nvim-cmp (via NvChad) |
| Navigation | Harpoon 2, Telescope, vim-tmux-navigator, Spectre |
| Git | gitsigns, Neogit, diffview |
| Debugging | nvim-dap, dap-ui, codelldb, GDB |
| Testing | neotest + neotest-ctest |
| AI | Copilot, Claude Code |
| UI | lualine, aerial, edgy (sidebar), barbecue (breadcrumbs), nvim-ufo (folding) |
| Formatting | conform.nvim (clang-format, stylua) |
| Terminal | toggleterm |
| Misc | vim-visual-multi, ouroboros (header/source switch), render-markdown |

## Improvement Roadmap

### 🔴 High Impact (Intuitiveness & Productivity)

#### 1. Replace `nvim-cmp` with `blink.cmp`
- **Why**: Faster (Rust backend), batteries-included completion with better defaults, less config needed.
- **Caveat**: NvChad uses nvim-cmp internally — may require overriding. Wait if stability is preferred.
- **Repo**: https://github.com/Saghen/blink.cmp

#### 2. Add `noice.nvim`
- **Why**: Replaces Neovim's default message/cmdline/popup UI with floating, searchable, dismissible notifications. Messages no longer interrupt workflow.
- **Repo**: https://github.com/folke/noice.nvim

#### 3. Add `fidget.nvim`
- **Why**: Shows LSP progress (indexing, formatting) as subtle inline spinners. No more silent background work with no feedback.
- **Repo**: https://github.com/j-hui/fidget.nvim

#### 4. Replace `nvim-spectre` with `grug-far.nvim`
- **Why**: Modern search & replace with live preview, better UI, and active maintenance. Spectre is archived/unmaintained.
- **Repo**: https://github.com/MagicDuck/grug-far.nvim

#### 5. Add `flash.nvim`
- **Why**: Superior motion/jump plugin. Much more intuitive than default `f`/`t`/`/` for navigating within visible buffer. Provides labeled jumps.
- **Repo**: https://github.com/folke/flash.nvim

### 🟡 Medium Impact (Quality of Life)

#### 6. Add `nvim-bqf`
- **Why**: Enhanced quickfix window with preview and fzf integration. Makes `gr` (references) and grep results much easier to navigate.
- **Repo**: https://github.com/kevinhwang91/nvim-bqf

#### 7. Enable format-on-save with toggle
- **Why**: Currently commented out in conform config. Add a toggle keybind (similar to existing autosave toggle) for on-demand formatting.
- **Action**: Uncomment and wire up `<leader>tf` to toggle format-on-save.

#### 8. Add `nvim-surround` or `mini.surround`
- **Why**: Essential text manipulation — wrap, change, delete surrounding characters (`"`, `(`, `{`, etc.). Fundamental for editing code.
- **Repo**: https://github.com/kylechui/nvim-surround

#### 9. Add `indent-blankline.nvim` v3
- **Why**: Visual indent guides help with deeply nested C++ code. Shows scope context.
- **Repo**: https://github.com/lukas-reineke/indent-blankline.nvim

#### 10. Add `oil.nvim` alongside NvimTree
- **Why**: Edit filesystem as a buffer (rename/move/create files naturally). More intuitive for quick file operations than a tree explorer.
- **Repo**: https://github.com/stevearc/oil.nvim

### 🟢 Config Tweaks (No new plugins)

#### 11. Fix `<C-k>` keybind conflict
- **Problem**: `<C-k>` in `on_attach.lua` (signature help) overrides tmux-navigator's `<C-k>` for split navigation.
- **Fix**: Remap signature help to `<C-S-k>` or `<leader>ck`.

#### 12. Consolidate conform config
- **Problem**: Formatters defined in both `plugins/init.lua` (clang-format) and `configs/conform.lua` (stylua). The `configs/conform.lua` isn't being loaded by anything.
- **Fix**: Merge all formatter config into `plugins/init.lua` conform setup.

#### 13. Add persistent undo
```lua
vim.opt.undofile = true
```
- **Why**: Undo history survives across sessions. Pairs well with the persistence.nvim session plugin.

#### 14. Add scrolloff
```lua
vim.opt.scrolloff = 8
```
- **Why**: Keeps cursor away from screen edges during navigation. Less disorienting.

#### 15. Clean up NvChad statusline override
- **Current state**: `statusline = { enabled = false }` in chadrc + lualine loaded separately.
- **Action**: Add a comment clarifying this is intentional, or remove NvChad's tabufline dependency if not needed.

## Suggested Implementation Order

1. `flash.nvim` — immediate navigation improvement, no conflicts
2. `noice.nvim` — better UX with zero workflow change
3. `fidget.nvim` — tiny plugin, instant feedback improvement
4. Replace Spectre → `grug-far.nvim` — drop-in improvement
5. Format-on-save toggle — config tweak only
6. Fix `<C-k>` keybind conflict — config tweak only
7. `nvim-bqf` — quickfix enhancement
8. `oil.nvim` — filesystem editing
9. `nvim-surround` — text manipulation
10. `blink.cmp` — larger migration, do last
