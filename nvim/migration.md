# A CLion-Feeling Neovim for C++/CMake in 2026 — Recommendation and Build

**TL;DR**
- **Switch from NvChad to LazyVim** as your baseline. NvChad is a beautifully themed, opinionated UI framework; LazyVim is a plugin-rich, language-extensible IDE distribution whose `:LazyExtras` system trivially adds the exact stack you want (clangd, cmake, DAP, Trouble, Telescope, neo-tree, noice, etc.). Staying on NvChad is viable but means re-implementing half of what LazyVim ships for free, and NvChad's docs explicitly note "NvChad does not provide any language configuration aside from lua."
- **The core CLion-feel stack** is: `clangd` + `clangd_extensions.nvim` (LSP, inlay hints, AST, memory, type hierarchy), `Civitasv/cmake-tools.nvim` (configure/build/run/debug, presets, kits, build types, `:CMakeDebug`), `nvim-dap` + `nvim-dap-ui` + `theHamsta/nvim-dap-virtual-text` + `codelldb` (visual debugger), `neo-tree.nvim` (CLion-like Project tool window), `aerial.nvim` (CLion Structure panel), `dropbar.nvim` (CLion navigation bar / breadcrumbs), `trouble.nvim` v3.7.1 (Problems panel), `telescope.nvim` or `fzf-lua` (Find in Path / Find Usages UI), `gitsigns.nvim` + `diffview.nvim` (VCS gutter + diff), `nvim-ufo` (modern folds), `kosayoda/nvim-lightbulb` v1.0.0 (CLion intention bulb, released 2025-07-08), `noice.nvim` + `nvim-notify` (polished cmdline/popups), and `blink.cmp` (the new fast completion engine LazyVim now defaults to).
- **Don't use tmux** in this setup — `toggleterm.nvim` + cmake-tools' built-in terminal/quickfix executors keep the build/run UX inside Neovim, identical in feel to CLion's Build and Run tool windows.

---

## Key Findings

### A. Baseline: LazyVim > NvChad for this specific goal

NvChad's own homepage frames it as "an attempt to make Neovim CLI as functional as an IDE while being very beautiful, blazing fast … 68 inbuilt beautifully ported & custom themes." That is exactly the framing: it is a fast, gorgeous shell. The official NvChad LSP docs are blunt that **"NvChad does not provide any language configuration aside from lua."** Everything C++/CMake/DAP-related is on you to wire by hand into NvChad's `lua/plugins/*.lua` after the v2.5 refactor (which removed the `custom/` directory and switched to using NvChad as a plugin imported by your starter repo).

LazyVim is the opposite philosophy: a thin, opinionated set of defaults plus a curated catalog of *language extras* and *editor extras* you toggle with `:LazyExtras`. The C++ extra (`lazyvim.plugins.extras.lang.clangd`) gives you, out of the box, clangd with `--background-index --clang-tidy --header-insertion=iwyu --completion-style=detailed --function-arg-placeholders --fallback-style=llvm`, `LspClangdSwitchSourceHeader` bound to `<leader>ch`, `p00f/clangd_extensions.nvim` pre-wired (AST, type hierarchy, memory usage, inlay hints, `cmp_scores` sorter), and an installed `codelldb` via Mason with `dap.configurations.cpp` for Launch File / Attach to Process. The CMake extra (`lazyvim.plugins.extras.lang.cmake`) auto-loads `Civitasv/cmake-tools.nvim` the moment it detects `CMakeLists.txt`, installs the `neocmake` LSP, plus `cmakelang` and `cmakelint`.

AstroNvim v4 is the closest alternative: it does ship an `astrocommunity.pack.cpp` that bundles clangd, clang-format, and clangd_extensions, and it has a strong IDE template repo. It's a reasonable second choice, but its plugin/community ecosystem is smaller than LazyVim's and the cmake-tools integration is not first-class.

**Recommendation:** migrate to LazyVim. The migration cost is one evening — the starter is a `git clone` of `LazyVim/starter` and your existing tastes (theme, keymaps) move over as overrides in `lua/plugins/`. You'll spend the saved time tuning the IDE feel rather than rebuilding the IDE.

**If you must stay on NvChad v2.5** (e.g., you love `base46` theming): you can absolutely reach feature parity, but plan to (a) put every custom plugin under `lua/plugins/*.lua` in the starter, (b) override clangd through `vim.lsp.config("clangd", { … })` in `lua/configs/lspconfig.lua` (per the v2.5 / Neovim 0.11 API), and (c) accept that NvChad's bespoke `tabufline` and `statusline` aren't trivially interchangeable with `bufferline.nvim` and `lualine.nvim` if you want winbar/breadcrumbs integrated.

### B. C++ semantic layer (the part CLion does best)

The current best stack is:

- **`clangd`** (installed via Mason), with the LazyVim-extra flags above. The `compile_commands.json` requirement is non-negotiable — either let `cmake-tools.nvim` symlink it into your project root (`cmake_compile_commands_options = { action = "soft_link" }` is the default), or add `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` to your top-level CMakeLists and symlink. Place a `.clangd` file at the repo root for project-wide tweaks (e.g. `--query-driver` for cross-compilers).
- **`p00f/clangd_extensions.nvim`** (active mirror at `sr.ht/~p00f/clangd_extensions.nvim`) — adds `:ClangdAST`, `:ClangdSymbolInfo`, `:ClangdTypeHierarchy`, `:ClangdMemoryUsage`, and a `cmp_scores`/`blink_scores` comparator for ranking completions the way clangd intends. Since Neovim 0.10, native `vim.lsp.inlay_hint()` covers inline inlay hints, so the plugin's own inline hints can be left off (`inlay_hints = { inline = false }`).
- **Completion: `blink.cmp` (v1.x)** — per the official `cmp.saghen.dev` docs (v1.10.2): "Blink uses a SIMD fuzzy matcher called `frizbee` which achieves ~6x the performance of fzf while ignoring typos." It's now LazyVim's default completion engine; `nvim-cmp` remains available as an opt-in extra. **Use blink.cmp** unless you have a custom nvim-cmp source you can't replace.
- **CLion-like features mapping** (all out-of-box once clangd is attached):
  - *Rename* → `vim.lsp.buf.rename()` (LazyVim binds `<leader>cr`), upgrade to `inc-rename.nvim` for an in-place preview that mimics CLion's rename dialog.
  - *Find Usages* → `vim.lsp.buf.references()` rendered in Trouble (`<leader>cl` opens "LSP Definitions / references / … (Trouble)" in v3).
  - *Code Actions* → `vim.lsp.buf.code_action()` with `nvim-lightbulb` v1.0.0 (released **2025-07-08**, first tagged release after years on `master`) for the 💡 indicator in the sign column — Neovim 0.11 still does not ship a built-in lightbulb.
  - *Hover / Signature help* → `K` / `<C-k>`, prettified by `noice.nvim` LSP override.
  - *Switch source/header* → `:LspClangdSwitchSourceHeader` (LazyVim binds `<leader>ch`).
  - *Call hierarchy / Type hierarchy* → `vim.lsp.buf.incoming_calls()` / `outgoing_calls()`, plus `:ClangdTypeHierarchy` for class hierarchies.
  - *Inlay hints (param names, deduced types)* → `vim.lsp.inlay_hint.enable(true)` (Neovim 0.10+); clangd serves them automatically. Inlay hint quality is excellent and is the single biggest "CLion feel" win.

### C. CMake integration

**`Civitasv/cmake-tools.nvim`** is the clear winner and the only plugin in the ecosystem whose stated goal is parity with VS Code's cmake-tools. Concretely it gives you:

- `:CMakeGenerate`, `:CMakeBuild`, `:CMakeRun`, `:CMakeInstall`, `:CMakeClean`
- `:CMakeSelectBuildType` (Debug / Release / RelWithDebInfo / MinSizeRel, or custom variants via `cmake-variants.json`)
- `:CMakeSelectConfigurePreset` and `:CMakeSelectBuildPreset` (full `CMakePresets.json` support)
- `:CMakeSelectKit` (compiler toolchain switching via `cmake-kits.json`)
- `:CMakeSelectBuildTarget` / `:CMakeSelectLaunchTarget`, plus `:CMakeLaunchArgs` for per-target argv (preserved across switches)
- **`:CMakeDebug`** — invokes nvim-dap on the current launch target after building. This is the magic command that makes Build-then-Debug feel like CLion's hammer-and-bug toolbar.
- `:CMakeRunTest` for ctest.

Recommended baseline config:

```lua
require("cmake-tools").setup({
  cmake_command = "cmake",
  ctest_command = "ctest",
  cmake_use_preset = true,
  cmake_regenerate_on_save = true,
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
  cmake_build_directory = function()
    return "out/${variant:buildType}"
  end,
  cmake_compile_commands_options = { action = "soft_link" },   -- symlink to project root for clangd
  cmake_executor = { name = "quickfix" },                       -- build output in the quickfix list (CLion's Build pane)
  cmake_runner   = { name = "toggleterm", opts = { direction = "horizontal" } },
  cmake_dap_configuration = { type = "codelldb", request = "launch", stopOnEntry = false, runInTerminal = false },
  cmake_notifications = { runner = { enabled = true }, executor = { enabled = true } },
})
```

The `cmake-variants.json` / `CMakePresets.json` files in your repo are auto-detected; cmake-tools exposes `get_build_type()`, `get_launch_target()`, `has_cmake_preset()` etc. that you can hang lualine components off so the status line shows current preset / build type / target — that's the CLion toolbar.

**Alternatives:**
- `Shatur/neovim-cmake` — the upstream that cmake-tools forked from; still works but smaller surface and no preset support.
- `cdelledonne/vim-cmake` — solid Vimscript option with `:CMakeGenerate`/`:CMakeBuild`/`:CMakeSwitch`, no DAP wiring.
- `stevearc/overseer.nvim` — generic task runner; pair it as the *executor* backend (`cmake_executor = { name = "overseer" }`) for a richer task UI than quickfix.

### D. The GUI / IDE-feel layer

Pane-by-pane, with the CLion equivalent and the 2025–2026 recommendation:

| CLion feature | Recommended plugin | Why |
|---|---|---|
| **Project tool window** (file tree) | `nvim-neo-tree/neo-tree.nvim` | More CLion-like than `nvim-tree.lua`. Built on `nui.nvim`/`plenary`, ships multiple sources (filesystem / buffers / git_status / document_symbols) in a single tree, has a polished preview mode (`P`), and is the LazyVim default. |
| **Structure tool window** | `stevearc/aerial.nvim` | Better than `hedyhli/outline.nvim` for your case because aerial supports both LSP and Treesitter providers, integrates with lualine, and offers the `AerialNav` miller-column view. |
| **Navigation bar / breadcrumbs** | `Bekaboo/dropbar.nvim` | CLion's navigation bar is essentially "IDE-like breadcrumbs, out of the box." Drop-down menus on click, mouse hover, pick mode (`<Leader>;`). Requires Neovim 0.11+. |
| **Status bar (bottom)** | `nvim-lualine/lualine.nvim` with cmake-tools components | The cmake-tools README shows a ready-made `evil_lualine` snippet that adds CMake preset / build type / kit / build target / launch target sections. This *is* the CLion bottom toolbar. |
| **Editor tabs** | `akinsho/bufferline.nvim` | Closer to CLion's tabs with diagnostics + close buttons + LSP-color indicators. |
| **Problems tool window** | `folke/trouble.nvim` v3 | v3 is a full rewrite with tree views, preview floats, and modes for diagnostics, LSP refs/defs/impls, telescope/fzf/snacks results, qf, and loclist. |
| **Find in Files / Find Usages popup** | `nvim-telescope/telescope.nvim` (or `ibhagwan/fzf-lua`) + Trouble integration | Telescope's `lsp_references`, `lsp_implementations`, `lsp_definitions`, `lsp_document_symbols`, `lsp_dynamic_workspace_symbols` cover CLion's Find Usages / Go to Symbol / Navigate by Name. |
| **VCS gutter + Annotate (blame)** | `lewis6991/gitsigns.nvim` + `sindrets/diffview.nvim` | Gitsigns gives gutter signs, inline blame, hunk staging/reset, word_diff. Diffview.nvim is the equivalent of CLion's "Show Diff" / merge tool window. |
| **Scrollbar with diagnostics/git** | `petertriho/nvim-scrollbar` (or `lewis6991/satellite.nvim`) | Reproduces CLion's right-edge map with error/warning/git markers. |
| **Indent guides + code folding** | `lukas-reineke/indent-blankline.nvim` v3 + `kevinhwang91/nvim-ufo` | UFO makes Neovim's fold look modern and keeps high performance. |
| **Intention bulb (💡)** | `kosayoda/nvim-lightbulb` v1.0.0 | Shows a lightbulb in the sign column whenever a `textDocument/codeAction` is available at the current cursor position. |
| **Polished cmdline / hover / messages** | `folke/noice.nvim` + `MunifTanjim/nui.nvim` + `rcarriga/nvim-notify` | Replaces the cmdline with a centered popup, routes `vim.notify` to animated toasts, and prettifies LSP hover/signature popups. |
| **Better `vim.ui.select/input`** | `stevearc/dressing.nvim` | Turns the default ugly `:CMakeSelectBuildType` prompt into a nice floating list with fuzzy filter. |
| **Inline diagnostics / virtual lines** | Built-in `vim.diagnostic.config({ virtual_text = true })` | Neovim 0.11 changed `virtual_text` from opt-out to opt-in, so set it explicitly. |
| **Symbol usage / code-lens-like counts** | `Wansmer/symbol-usage.nvim` (optional) | Renders reference/definition/implementation counts above functions, the way CLion's Code Vision does. |

### E. Debugging (CLion's debugger UI is a major IDE-feel pillar)

The complete, current-best stack:

```lua
-- 1. The core
{ "mfussenegger/nvim-dap" }

-- 2. Visual UI panels (variables, watches, scopes, breakpoints, stacks, REPL)
{ "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  opts = {} }

-- 3. Inline variable values (CLion-style values-next-to-code while stepping)
{ "theHamsta/nvim-dap-virtual-text", opts = { virt_text_pos = "inline" } }

-- 4. Persistent breakpoints across sessions
{ "Weissle/persistent-breakpoints.nvim",
  opts = { load_breakpoints_event = { "BufReadPost" } } }

-- 5. The debug adapter: codelldb (best C++ DAP experience)
require("dap").adapters.codelldb = {
  type = "server", port = "${port}",
  executable = { command = "codelldb", args = { "--port", "${port}" } },
}
```

Then **wire cmake-tools to nvim-dap** by setting `cmake_dap_configuration` in cmake-tools' setup (shown in §C). After that, the workflow is:

1. `:CMakeSelectConfigurePreset` (or `:CMakeSelectBuildType Debug`)
2. `:CMakeSelectLaunchTarget`
3. `:CMakeLaunchArgs ...` (optional, per-target argv)
4. `:CMakeDebug` — builds the target then launches it under codelldb; dap-ui opens automatically.

### F. Putting it together

**My recommendation: migrate to LazyVim.** The migration is one evening; the maintenance payoff is permanent. Here's the concrete path.

#### Step 1 — Move the config

```bash
# back up your NvChad config
mv ~/.config/nvim          ~/.config/nvim.nvchad.bak
mv ~/.local/share/nvim     ~/.local/share/nvim.nvchad.bak

# clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim   # let lazy.nvim bootstrap everything
```

#### Step 2 — Enable the language and editor extras

Run `:LazyExtras` and toggle:

- `lang.clangd` (clangd + clangd_extensions + DAP codelldb config)
- `lang.cmake` (cmake-tools.nvim + neocmake LSP + cmakelang/cmakelint)
- `dap.core` (nvim-dap + nvim-dap-ui + nvim-dap-virtual-text + Mason DAP)
- `editor.aerial` (Structure panel)
- `editor.inc-rename` (CLion-like rename preview)
- `editor.fzf` or `editor.telescope` (pickers)
- (Trouble v3 is already default in current LazyVim.)
- `ui.edgy` (CLion-style docked side panels; pins neo-tree/aerial/trouble/dap-ui to fixed edges)
- `ui.mini-animate` *(optional)* and `ui.treesitter-context`
- `coding.blink` (already the default in current LazyVim; opt in to `coding.nvim-cmp` only if you have an irreplaceable cmp source)

That single command gives you ~80% of the CLion-feel surface.

#### Step 3 — Add the IDE-feel plugins LazyVim doesn't ship by default

Drop these files into `~/.config/nvim/lua/plugins/`:

```lua
-- lua/plugins/ide-feel.lua
return {
  -- Breadcrumbs (CLion navigation bar)
  { "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },

  -- Modern folding
  { "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {} },

  -- Code action lightbulb (💡 in sign column)
  { "kosayoda/nvim-lightbulb",
    version = "*",
    event = "LspAttach",
    opts = { autocmd = { enabled = true } } },

  -- Scrollbar with diagnostics/git markers
  { "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    opts = { handlers = { gitsigns = true, search = true } } },

  -- Reference/def/impl counts above symbols (CLion code vision)
  { "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {} },

  -- Persistent DAP breakpoints
  { "Weissle/persistent-breakpoints.nvim",
    event = "VeryLazy",
    opts = { load_breakpoints_event = { "BufReadPost" } } },

  -- Diff/merge tool window
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

  -- Polished cmdline/popups
  { "folke/noice.nvim",
    event = "VeryLazy",
    opts = { presets = { command_palette = true, long_message_to_split = true,
                          lsp_doc_border = true, inc_rename = true } },
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
}
```

```lua
-- lua/plugins/cmake.lua  (overrides LazyVim's cmake extra defaults)
return {
  { "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_use_preset = true,
      cmake_regenerate_on_save = true,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_directory = function() return "out/${variant:buildType}" end,
      cmake_compile_commands_options = { action = "soft_link" },
      cmake_executor = { name = "quickfix" },
      cmake_runner   = { name = "toggleterm" },
      cmake_dap_configuration = {
        type = "codelldb", request = "launch",
        stopOnEntry = false, runInTerminal = false,
      },
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>",              desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>",                 desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>",                   desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>",                 desc = "CMake Debug" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>",     desc = "Select Build Target" },
      { "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>",    desc = "Select Launch Target" },
      { "<leader>cT", "<cmd>CMakeSelectBuildType<cr>",       desc = "Select Build Type" },
      { "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "Select Configure Preset" },
      { "<leader>cB", "<cmd>CMakeSelectBuildPreset<cr>",     desc = "Select Build Preset" },
      { "<leader>ck", "<cmd>CMakeSelectKit<cr>",             desc = "Select Kit" },
      { "<leader>cx", "<cmd>CMakeLaunchArgs<cr>",            desc = "Set Launch Args" },
      { "<leader>cc", "<cmd>CMakeClean<cr>",                 desc = "CMake Clean" },
    } },
}
```

```lua
-- lua/plugins/clangd-tweak.lua  (extend the LazyVim clangd extra)
return {
  { "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd", "--background-index", "--clang-tidy",
            "--header-insertion=iwyu", "--completion-style=detailed",
            "--function-arg-placeholders", "--fallback-style=llvm",
            "--all-scopes-completion", "--cross-file-rename",
            "--pch-storage=memory", "-j=8",
          },
          init_options = { usePlaceholders = true, completeUnimported = true, clangdFileStatus = true },
        },
      },
    } },
}
```

#### Step 4 — Pin the side panels (CLion-style fixed docks)

Enable `lazyvim.plugins.extras.ui.edgy` (already an extra). Edgy lets you pin `neo-tree` to the left, `aerial` and `Trouble symbols` to the right, and `dap-ui` panels to the bottom — exactly the four-corner layout CLion uses by default.

#### Step 5 — Daily workflow

- **Open project** → `nvim ~/path/to/repo` → cmake-tools auto-loads on `CMakeLists.txt`.
- **First time:** `<leader>cp` to pick a configure preset, `<leader>cg` to generate, then `<leader>cl` to select a launch target.
- **Edit-loop:** clangd lights up inlay hints + diagnostics; `gd` / `gr` / `<leader>cr` (rename) / `<leader>ca` (code action — 💡 in gutter); `<leader>fs` (Telescope/fzf symbols); `<leader>e` (neo-tree); `<leader>cs` (aerial Structure).
- **Build / Run:** `<leader>cb` for build (quickfix opens on error), `<leader>cr` to run (toggleterm popup), `<leader>cd` to debug (dap-ui opens automatically with scopes/stacks/watches/repl; inline values appear next to variables; F5/F10/F11 step controls bound by `dap.core` extra).
- **Problems panel:** `<leader>xx`.
- **VCS:** `]h` / `[h` next/prev hunk, `<leader>ghp` preview, `:Gitsigns blame`, `:DiffviewOpen` for full diff window.

#### Known pain points and how to neutralize them

1. **`compile_commands.json` discovery.** Make sure cmake-tools' `cmake_compile_commands_options = { action = "soft_link" }` is on, *and* that your clangd `root_markers` include `compile_commands.json`, `.clangd`, `CMakeLists.txt`, `.git`.
2. **cmake-tools eagerly loading nvim-dap.** Enabling both `lang.cmake` and `dap.core` can cause nvim-dap to load on every file entry. If startup time matters set `cmake-tools.nvim`'s `lazy = true` with an explicit `cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeDebug" }`.
3. **blink.cmp v2 churn.** Per blink.cmp's own README, "V2 is under active development with many breaking changes. Consider staying on stable by using `branch = 'v1'` or `version = \"1.*\"` in your lazy.nvim config."
4. **clangd UTF offset bug.** In some LazyVim+clangd combos, set `capabilities = { offsetEncoding = { "utf-16" } }` (the LazyVim extra already does this).
5. **Noice + Neovim version.** Folke's README says "It is highly recommended to use Neovim >= 0.11, since it fixes some issues related to vim.ui_attach." Be on 0.11.x+ before enabling noice.

---

## Recommendations (staged)

**Now (week 1) — get the IDE feel.**

1. Back up the NvChad config, clone LazyVim starter, run `:LazyExtras` and enable `lang.clangd`, `lang.cmake`, `dap.core`, `editor.aerial`, `editor.inc-rename`, `ui.edgy`, plus your picker (`editor.telescope` or `editor.fzf`).
2. Drop in the `lua/plugins/ide-feel.lua`, `cmake.lua`, `clangd-tweak.lua` snippets above.
3. Set `vim.lsp.inlay_hint.enable(true)` and `vim.diagnostic.config({ virtual_text = true, virtual_lines = { current_line = true } })`.

**Next (week 2) — tune the rough edges.**

4. Pin DAP UI layout with edgy; verify `:CMakeDebug` opens dap-ui and shows inline values.
5. Add `nvim-scrollbar` + `symbol-usage.nvim` + `nvim-lightbulb` + `nvim-ufo` for the last 20% of IDE polish.
6. Add `noice.nvim` and `inc-rename` for the CLion-like rename/cmdline UX.

**Optional (when stable) — try `igorlfs/nvim-dap-view`** instead of `nvim-dap-ui` if dap-ui's release cadence bothers you. dap-view is the actively-maintained, single-window, Neovim-0.11-native alternative.

---

## Caveats

- **Neovim isn't CLion and never will be.** You will not get CLion's graphical CMake project model UI, CLion's refactorings beyond rename/extract (e.g. *Inline*, *Change Signature*, *Pull Members Up*) — clangd has no equivalent — or CLion's memory/data view in the debugger. Expect to retain CLion for big refactors and use Neovim for daily edit/build/debug.
- **clangd's call-hierarchy** is functional but less polished than CLion's. `:ClangdTypeHierarchy` partially fills the gap for class hierarchies.
- **Some recommended plugins are pre-1.0 or in flux.** noice.nvim's own README still calls itself "Highly experimental"; blink.cmp v2 is breaking; nvim-dap-view requires Neovim 0.11+; nvim-dap-ui's last release is over a year old.
- **cmake-tools.nvim's `:CMakeDebug` quality varies with adapter.** codelldb is the most reliable.
- **UI overlap.** If you enable `nvim-lightbulb` *and* `symbol-usage.nvim` *and* inlay hints *and* virtual diagnostics *and* gitsigns blame, the right margin can get visually busy. Tune priorities accordingly.
- **NvChad option is still real.** Everything recommended works on NvChad v2.5 — you just put the same plugin specs under your starter's `lua/plugins/*.lua` instead of using `:LazyExtras`. The decision is about *how much wiring you want to do yourself*.
