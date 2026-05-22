return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- Override LSP handlers for better UI
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        -- Show LSP signature help in a floating window
        signature = { enabled = true },
      },
      presets = {
        bottom_search = true, -- classic bottom search bar
        command_palette = true, -- cmdline and popupmenu together
        long_message_to_split = true, -- long messages go to split
        lsp_doc_border = true, -- border around hover/signature docs
      },
      routes = {
        -- Skip "written" messages
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts = { skip = true },
        },
      },
    },
  },
}
