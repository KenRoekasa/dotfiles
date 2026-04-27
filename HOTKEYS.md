# Hotkeys Reference

> Leader key = `Space`

---

## WezTerm (Leader = `Ctrl+b`)

### Panes
| Key | Action |
|-----|--------|
| `Ctrl+b %` | Split pane vertically |
| `Ctrl+b "` | Split pane horizontally |
| `Ctrl+b h/j/k/l` | Navigate panes |
| `Ctrl+b ←↑↓→` | Navigate panes |
| `Ctrl+b Ctrl+←↑↓→` | Resize panes |
| `Ctrl+b z` | Zoom/unzoom pane (fullscreen) |
| `Ctrl+b Space` | Rotate panes |
| `Ctrl+b x` | Close pane |

### Tabs
| Key | Action |
|-----|--------|
| `Ctrl+b c` | New tab |
| `Ctrl+b n/p` | Next/prev tab |
| `Ctrl+b 1-9` | Go to tab N |
| `Ctrl+b &` | Close tab |
| `Ctrl+b ,` | Rename tab |
| `Ctrl+b w` | Tab navigator |

### Misc
| Key | Action |
|-----|--------|
| `Ctrl+b [` | Copy mode (scroll back) |
| `Ctrl+b b` | Send Ctrl+b to app |

---

## Neovim — Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate splits |
| `Ctrl+b` | Go to definition (CLion-style) |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `Ctrl+o` | Navigate back |
| `Alt+Left/Right` | Navigate back/forward |
| `Ctrl+LeftClick` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Find references |
| `F4` | Go to source file (in diffview) |
| `F10` | Switch header/source |
| `Tab` | Next buffer |
| `Shift+Tab` | Prev buffer |
| `Space x` | Close buffer |

---

## Neovim — LSP / Code

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `Alt+Enter` | Code action / quick fix |
| `Ctrl+p` (insert) | Parameter info |
| `Ctrl+k` | Signature help |
| `Space rn` | Rename symbol |
| `Space ca` | Code action |
| `Space ct` | Type definition |
| `Space ci` | Incoming calls |
| `Space co` | Outgoing calls |
| `Space fm` | Format code |
| `F2` | Next error/diagnostic |
| `Space xp` | Previous error/diagnostic |

---

## Neovim — Search & Find

| Key | Action |
|-----|--------|
| `Space ff` | Find file |
| `Space fg` | Live grep |
| `Space fw` | Grep word under cursor |
| `Space fg` (visual) | Grep selected text |
| `Space fa` | Find action/command |
| `Space sk` | Search keymaps |
| `Space ss` | Workspace symbols |
| `Space sd` | Document symbols |

---

## Neovim — Git

| Key | Action |
|-----|--------|
| `Space gg` / `Alt+9` | Neogit status |
| `Space gd` | Diff view open |
| `Space gh` | File history (diffview) |
| `Space gH` | Branch history (diffview) |
| `Space gx` | Close diffview |
| `F4` | Open source file from diffview |
| `Ctrl+o` | Open source file from diffview |

---

## Neovim — Testing

| Key | Action |
|-----|--------|
| `Shift+F10` | Run nearest test |
| `Ctrl+Shift+F10` | Run file tests |
| `Space tt` | Run nearest test |
| `Space tf` | Run file tests |
| `Space ts` | Toggle test summary |
| `Space to` | Show test output |
| `Space tO` | Toggle output panel |
| `Space tS` | Stop test |
| `Space td` | Debug test |

---

## Neovim — Debugging (DAP)

| Key | Action |
|-----|--------|
| `F9` | Resume / start debug |
| `F7` | Step into |
| `F8` | Step over |
| `Space do` | Step out |
| `Space dx` | Stop debugger |
| `Space db` | Toggle breakpoint |
| `Space dB` | Conditional breakpoint |
| `Space de` | Evaluate expression |
| `Space dc` | Run to cursor |
| `Space dr` | Open REPL |

---

## Neovim — Build (CMake)

| Key | Action |
|-----|--------|
| `Space cb` | Build |
| `Space cr` | Run |
| `Space cc` | CMake generate |

---

## Neovim — Harpoon (File Bookmarks)

| Key | Action |
|-----|--------|
| `Space ha` | Add file to harpoon |
| `Space hh` | Open harpoon menu |
| `Space 1-4` | Jump to file 1-4 |
| `Space hn/hp` | Next/prev harpoon file |

---

## Neovim — Sessions

| Key | Action |
|-----|--------|
| `Space qs` | Restore session (cwd) |
| `Space qS` | Pick session |
| `Space ql` | Restore last session |
| `Space qd` | Stop session recording |

---

## Neovim — Terminal & Tools

| Key | Action |
|-----|--------|
| `Space tm` | Toggle terminal |
| `Alt+1` | Toggle file tree |
| `Space ta` | Toggle autosave on focus lost |
| `Space mr` | Toggle markdown render |

---

## Neovim — Copilot (insert mode)

| Key | Action |
|-----|--------|
| `Ctrl+y` | Accept suggestion |
| `Alt+]` / `Alt+[` | Next/prev suggestion |
| `Ctrl+]` | Dismiss suggestion |
| `Space cp` | Open Copilot panel |

---

## Neovim — Claude Code

| Key | Action |
|-----|--------|
| `Space ac` | Toggle Claude Code |
| `Space af` | Focus Claude Code |
| `Space ar` | Resume Claude Code |
| `Space as` (visual) | Send selection to Claude |
| `Space aa` | Accept diff |
| `Space ad` | Deny diff |

---

## Neovim — Multi-cursor

| Key | Action |
|-----|--------|
| `Alt+j` | Add cursor below |
| `Alt+k` | Add cursor above |
| `Alt+d` | Select next occurrence |
| `Ctrl+n` | Select next occurrence (default) |
| `Esc` | Exit multi-cursor mode |

---

## Neovim — Folds

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `za` | Toggle fold under cursor |
| `zK` | Peek fold |
