# LazyVim Keybindings Reference

## CLion-Style Shortcuts

| Key | Action |
|-----|--------|
| `F2` | Next Error/Diagnostic |
| `Shift+F2` | Previous Error/Diagnostic |
| `F4` | Jump to Source (go to definition) |
| `F10` | Switch Source/Header |
| `Alt+O` | Switch Source/Header |
| `Alt+1` | File Tree Toggle |
| `Alt+4` | Problems/Diagnostics Panel |
| `Alt+7` | Structure/Outline (Aerial) |
| `Ctrl+Shift+N` | Find File |
| `Ctrl+Shift+F` | Find in Path (live grep) |
| `Ctrl+Click` | Go to Definition |
| `Alt+Left` | Navigate Back |
| `Alt+Right` | Navigate Forward |

## Core LazyVim Keybindings (built-in)

| Key | Action |
|-----|--------|
| `<leader>` | Space |
| `<leader>e` | File Explorer (neo-tree) |
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent Files |
| `<leader>gg` | Lazygit |
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>cr` | Rename Symbol |
| `<leader>ca` | Code Action |
| `<leader>cf` | Format |
| `<leader>uC` | Change Colorscheme |
| `gd` | Go to Definition |
| `gr` | References |
| `K` | Hover Documentation |
| `]d` / `[d` | Next/Prev Diagnostic |
| `]h` / `[h` | Next/Prev Git Hunk |

## CMake (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>cg` | CMake Generate |
| `<leader>cb` | CMake Build |
| `<leader>cR` | CMake Run |
| `<leader>cd` | CMake Debug |
| `<leader>ct` | Select Build Target |
| `<leader>cl` | Select Launch Target |
| `<leader>cT` | Select Build Type |
| `<leader>cp` | Select Configure Preset |
| `<leader>cB` | Select Build Preset |
| `<leader>ck` | Select Kit |
| `<leader>cx` | Set Launch Args |
| `<leader>cc` | CMake Clean |

## DAP Debugging

| Key | Action |
|-----|--------|
| `<F5>` | Continue / Start |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<F12>` | Step Out |
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>dr` | REPL |
| `<leader>du` | DAP UI |

## Testing (`<leader>t`)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>td` | Debug nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop test |

## Navigation

| Key | Action |
|-----|--------|
| `s` | Flash Jump (type chars, pick label) |
| `S` | Flash Treesitter (select by syntax) |
| `r` (operator) | Remote Flash |
| `-` | Oil (filesystem as buffer) |
| `<leader>sr` | Search & Replace (grug-far) |
| `<leader>sw` | Search word under cursor |

## AI

| Key | Action |
|-----|--------|
| `<C-y>` (insert) | Accept Copilot suggestion |
| `<M-]>` / `<M-[>` | Next/Prev Copilot suggestion |
| `<leader>ac` | Toggle Claude Code |
| `<leader>af` | Focus Claude Code |
| `<leader>as` (visual) | Send selection to Claude |

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gd` | Diffview Open |
| `<leader>gh` | File History |
| `<leader>gH` | Branch History |
| `<leader>gx` | Close Diffview |

## Editing

| Key | Action |
|-----|--------|
| `<M-d>` | Select next occurrence (multicursor) |
| `<M-j>` / `<M-k>` | Add cursor below/above |
| `ys{motion}{char}` | Surround add |
| `cs{old}{new}` | Surround change |
| `ds{char}` | Surround delete |

## Misc

| Key | Action |
|-----|--------|
| `<leader>ta` | Toggle autosave |
| `<leader>tf` | Toggle format on save |
| `<leader>mr` | Toggle Markdown Render |
| `<leader>mp` | Markdown Preview (browser) |
| `<leader>ch` | Switch Source/Header |
