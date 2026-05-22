-- UI overrides: noice + fidget + diagnostics
return {
  -- Polished cmdline/popups/notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        inc_rename = true,
      },
      routes = {
        { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
      },
    },
  },

  -- LSP progress spinner
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = { notification = { window = { winblend = 0 } } },
  },

  -- Enable inlay hints and virtual text diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.lsp.inlay_hint.enable(true)
      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  },
}
