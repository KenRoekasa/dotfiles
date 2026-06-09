# Hotkeys Reference

> Leader key = `Space`

---

## ⭐ Essential Hotkeys

### WezTerm
| Key | Action |
|-----|--------|
| `Ctrl+Space c` | New tab |
| `Ctrl+Space %` | Split vertical |
| `Ctrl+Space "` | Split horizontal |
| `Ctrl+Space h/j/k/l` | Navigate panes |
| `Ctrl+Space z` | Zoom pane (fullscreen toggle) |
| `Ctrl+Space Space` | Rotate panes |

### Navigation
| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate nvim splits |
| `Ctrl+o` | Navigate back |
| `Alt+Left/Right` | Navigate back/forward |
| `F4` | Go to source file |
| `F10` | Switch header/source |
| `Tab / Shift+Tab` | Next/prev buffer |
| `Space x` | Close buffer |
| `Space fb` | List open buffers |

### Find (all under `Space f`)
| Key | Action |
|-----|--------|
| `Space ff` | Find file |
| `Space fg` | Live grep |
| `Space fg` (visual) | Grep selected text |
| `Space fa` | Find action/command |
| `Space fk` | Search keymaps |
| `Space fs` | Document symbols |
| `Space fS` | Workspace symbols |
| `Space fb` | Open buffers |
| `Space fd` | Diagnostics |
| `Space fr` | Recent files |

### Code
| Key | Action |
|-----|--------|
| `Alt+Enter` | Code action / quick fix |
| `K` | Hover docs |
| `Space rn` | Rename symbol |
| `Space fm` | Format code |
| `F2` | Next error |
| `Alt+j/k` | Add cursor below/above |
| `Alt+d` | Select next occurrence |

### Git
| Key | Action |
|-----|--------|
| `Alt+9` | Neogit |
| `Space gh` | File history |
| `Space gx` | Close diffview |

### Testing & Build
| Key | Action |
|-----|--------|
| `Shift+F10` | Run nearest test |
| `Ctrl+Shift+F10` | Run file tests |
| `F9` | Start/resume debug |
| `F8` | Step over |
| `F7` | Step into |
| `Space db` | Toggle breakpoint |
| `Space cb` | CMake build |
| `Space cr` | CMake run |

### Tools
| Key | Action |
|-----|--------|
| `Alt+1` | File tree |
| `Space tm` | Terminal |
| `Space ac` | Toggle Claude Code |
| `Ctrl+y` | Accept Copilot suggestion |
| `Space qs` | Restore session |
| `Space ta` | Toggle autosave |

---

## WezTerm (Leader = `Ctrl+Space`)

### Panes
| Key | Action |
|-----|--------|
| `Ctrl+Space %` | Split pane vertically |
| `Ctrl+Space "` | Split pane horizontally |
| `Ctrl+Space h/j/k/l` | Navigate panes |
| `Ctrl+Space ←↑↓→` | Navigate panes |
| `Ctrl+Space Ctrl+←↑↓→` | Resize panes |
| `Ctrl+Space z` | Zoom/unzoom pane (fullscreen) |
| `Ctrl+Space Space` | Rotate panes |
| `Ctrl+Space x` | Close pane |

### Tabs
| Key | Action |
|-----|--------|
| `Ctrl+Space c` | New tab |
| `Ctrl+Space n/p` | Next/prev tab |
| `Ctrl+Space 1-9` | Go to tab N |
| `Ctrl+Space &` | Close tab |
| `Ctrl+Space ,` | Rename tab |
| `Ctrl+Space w` | Tab navigator |

### Misc
| Key | Action |
|-----|--------|
| `Ctrl+Space [` | Copy mode (scroll back) |
| `Ctrl+Space b` | Send Ctrl+b to app |

---

## Neovim — Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate splits |
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

## Neovim — Find (`<leader>f`)

All picker / search functionality is consolidated under `<leader>f`.

### Files & Buffers
| Key | Action |
|-----|--------|
| `Space ff` | Find files (root) |
| `Space fF` | Find files (cwd) |
| `Space fr` | Recent files |
| `Space fR` | Recent files (cwd) |
| `Space fc` | Find config file |
| `Space fb` | Open buffers |
| `Space fB` | Open buffers (all) |
| `Space fl` | Buffer lines |
| `Space fe` | File explorer (root) |
| `Space fE` | File explorer (cwd) |

### Grep
| Key | Action |
|-----|--------|
| `Space fg` | Live grep (root) |
| `Space fg` (visual) | Grep selection (root) |
| `Space fG` | Live grep (cwd) |
| `Space fw` | Grep word under cursor (root) |
| `Space fW` | Grep word under cursor (cwd) |
| `Space fw` (visual) | Grep selection (root) |
| `Space fW` (visual) | Grep selection (cwd) |

### Symbols & Diagnostics
| Key | Action |
|-----|--------|
| `Space fs` | Document symbols |
| `Space fS` | Workspace symbols |
| `Space fd` | Diagnostics (workspace) |
| `Space fD` | Diagnostics (buffer) |

### Vim Internals
| Key | Action |
|-----|--------|
| `Space fa` | Commands (action palette) |
| `Space fA` | Auto commands |
| `Space fk` | Keymaps |
| `Space fh` | Help pages |
| `Space fH` | Highlight groups |
| `Space fM` | Man pages |
| `Space f'` | Marks |
| `Space f"` | Registers |
| `Space f/` | Search history |
| `Space f;` | Command history |

### Lists
| Key | Action |
|-----|--------|
| `Space fj` | Jumplist |
| `Space fq` | Quickfix list |
| `Space fL` | Location list |

### Misc
| Key | Action |
|-----|--------|
| `Space ft` | Todo comments |
| `Space fT` | Todo / Fix / Fixme |
| `Space fp` | Resume last picker |
| `Space fx` | Search & replace (grug-far) |
| `Space fX` | Search & replace word under cursor |
| `Space fm` | Format code |

---

## Neovim — Search & Find (legacy)

---

## Neovim — Git

| Key | Action |
|-----|--------|
| `Space gg` / `Alt+9` | Neogit status |
| `Space gd` | Diff view open |
| `Space gf` | File history (diffview) |
| `Space gH` | Branch history (diffview) |
| `Space gx` | Close diffview |
| `]h` / `[h` | Next / prev hunk |
| `F7` / `Shift+F7` | Next / prev hunk (diff-aware) |
| `Space gh` | Preview hunk |
| `Space gs` | Stage hunk |
| `Space gr` | Reset hunk |
| `Space gb` | Blame line |
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
| `Space uf` | Toggle auto-format (global) |
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
