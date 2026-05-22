-- Git: extend LazyVim defaults with diffview
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
    opts = {
      file_history_panel = {
        listing_style = "list",
        win_config = { position = "bottom", height = 16 },
      },
    },
  },
}
