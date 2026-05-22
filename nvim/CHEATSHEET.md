# Neovim Cheat Sheet

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CLION-STYLE SHORTCUTS                                │
├─────────────────────────────────────────────────────────────────────────────┤
│  F2 / Shift+F2      Next / Previous Error                                   │
│  F4                  Jump to Source (definition)                              │
│  F10 / Alt+O        Switch Source ↔ Header                                   │
│  Alt+1              File Tree        Alt+4    Problems                        │
│  Alt+7              Structure/Outline                                         │
│  Ctrl+Shift+N       Find File        Ctrl+Shift+F  Find in Path              │
│  Ctrl+Click         Go to Definition                                         │
│  Alt+← / Alt+→     Navigate Back / Forward                                   │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                              LEADER = SPACE                                  │
├──────────────────────────────┬──────────────────────────────────────────────┤
│  FINDING THINGS              │  CODE                                         │
│  <leader>ff  Find File       │  <leader>cr  Rename Symbol                    │
│  <leader>fg  Live Grep       │  <leader>ca  Code Action                      │
│  <leader>fb  Buffers         │  <leader>cf  Format                           │
│  <leader>fr  Recent Files    │  <leader>ch  Switch Header/Source             │
│  <leader>sr  Search/Replace  │  gd          Go to Definition                 │
│  <leader>sw  Search Word     │  gr          References                       │
│  <leader>sk  Keymaps         │  K           Hover Docs                       │
├──────────────────────────────┼──────────────────────────────────────────────┤
│  CMAKE                       │  DEBUGGING (DAP)                              │
│  <leader>cg  Generate        │  F5          Continue / Start                  │
│  <leader>cb  Build           │  F10         Step Over                         │
│  <leader>cR  Run             │  F11         Step Into                         │
│  <leader>cd  Debug           │  F12         Step Out                          │
│  <leader>ct  Build Target    │  <leader>db  Toggle Breakpoint                 │
│  <leader>cl  Launch Target   │  <leader>dB  Conditional Breakpoint            │
│  <leader>cT  Build Type      │  <leader>du  DAP UI                            │
│  <leader>cp  Configure Preset│  <leader>dr  REPL                              │
│  <leader>cx  Launch Args     │                                                │
│  <leader>cc  Clean           │                                                │
├──────────────────────────────┼──────────────────────────────────────────────┤
│  TESTING                     │  GIT                                           │
│  <leader>tt  Run Nearest     │  <leader>gg  Lazygit                           │
│  <leader>td  Debug Nearest   │  <leader>gd  Diffview Open                     │
│  <leader>tf  Run File        │  <leader>gh  File History                      │
│  <leader>ts  Test Summary    │  <leader>gH  Branch History                    │
│  <leader>to  Test Output     │  <leader>gx  Close Diffview                    │
│  <leader>tO  Output Panel    │  ]h / [h     Next/Prev Hunk                    │
│  <leader>tS  Stop Test       │                                                │
├──────────────────────────────┼──────────────────────────────────────────────┤
│  AI                          │  UI TOGGLES                                    │
│  <C-y>       Accept Copilot  │  <leader>e   File Explorer                     │
│  <M-]>/<M-[> Next/Prev Sugg │  <leader>uC  Change Theme                      │
│  <leader>ac  Claude Code     │  <leader>ta  Toggle Autosave                   │
│  <leader>af  Focus Claude    │  <leader>tf  Toggle Format-on-Save             │
│  <leader>as  Send to Claude  │  <leader>xx  Diagnostics (Trouble)             │
├──────────────────────────────┼──────────────────────────────────────────────┤
│  EDITING                     │  NAVIGATION                                    │
│  <M-d>       Multi-select    │  s           Flash Jump                        │
│  <M-j>/<M-k> Cursor ↓/↑     │  S           Flash Treesitter                  │
│  ys{m}{c}    Surround Add    │  -           Oil (parent dir)                  │
│  cs{o}{n}    Surround Change │  ]d / [d     Next/Prev Diagnostic              │
│  ds{c}       Surround Delete │                                                │
├──────────────────────────────┼──────────────────────────────────────────────┤
│  MARKDOWN                    │  LAZYGIT (inside lazygit)                      │
│  <leader>mr  Toggle Render   │  q / Esc     Close                             │
│  <leader>mp  Browser Preview │  e           Edit file in Neovim               │
│                              │  o           Open file at diff line             │
└──────────────────────────────┴──────────────────────────────────────────────┘
```

> **Tip:** Press `<leader>` (Space) and wait — which-key will show all available options.
> Use `<leader>sk` to search all keybindings interactively.
