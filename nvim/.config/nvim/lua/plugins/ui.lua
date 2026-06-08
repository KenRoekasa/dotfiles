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

  -- fzf-lua UI: match arbareus (tall window, vertical preview at bottom).
  -- Also override LazyVim's <leader>fg (git_files) → live_grep.
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>",   desc = "Live Grep",      mode = "n" },
      { "<leader>fg", "<cmd>FzfLua grep_visual<CR>", desc = "Grep Selection", mode = "x" },
    },
    opts = {
      winopts = {
        width   = 0.85,
        height  = 0.80,
        preview = { layout = "vertical", vertical = "down:45%" },
      },
    },
  },
}
