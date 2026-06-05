-- Extend the LazyVim clangd extra with additional flags
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--all-scopes-completion",
            "--cross-file-rename",
            "--pch-storage=memory",
            "-j=8",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          handlers = {
            -- Suppress spurious -32602 errors from documentHighlight before index is ready
            ["textDocument/documentHighlight"] = function() end,
          },
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
            { "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
            { "<F10>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
          },
        },
      },
    },
  },
}
