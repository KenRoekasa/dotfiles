local on_attach = require("plugins.lsp.on_attach")

return {
  -- Completion: LSP source
  { "hrsh7th/cmp-nvim-lsp" },

  -- Mason & LSP installer
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "cmake_language_server",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- LSPConfig setup
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- clangd: C/C++ with background indexing and clang-tidy
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders=true",
        },
      })

      -- cmake language server
      vim.lsp.config("cmake", {
        capabilities = capabilities,
      })

      vim.lsp.enable({ "clangd", "cmake" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          on_attach(client, args.buf)
        end,
      })
    end,
  },
}
