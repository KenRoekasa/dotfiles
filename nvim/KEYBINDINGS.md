# LazyVim Keybindings Reference

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
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |
| `<leader>tS` | Stop test |

## Navigation

| Key | Action |
|-----|--------|
| `s` | Flash Jump (type chars, pick label) |
| `S` | Flash Treesitter (select by syntax) |
| `-` | Oil (filesystem as buffer) |
| `Ctrl+Click` | Go to Definition |
| `Alt+Left` | Navigate Back |
| `Alt+Right` | Navigate Forward |
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

---

## Old NvChad Alt-Key Bindings (for reference)

These were used in the NvChad setup and are no longer active:

| Old Key | Was | Now |
|---------|-----|-----|
| `Alt-1` | File tree | `<leader>e` |
| `Alt-7` | Structure/Outline | `<leader>cs` (aerial) |
| `Alt-4` | Problems | `<leader>xx` |
| `Alt-9` | Git (Neogit) | `<leader>gg` (lazygit) |
| `Alt-0` | Diffview | `<leader>gd` |
