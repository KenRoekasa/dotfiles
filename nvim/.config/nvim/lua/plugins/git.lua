-- Git: extend LazyVim defaults with diffview and gitsigns hunk keymaps
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end
        map("]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("<leader>gh", gs.preview_hunk,             "Preview hunk")
        map("<leader>gs", gs.stage_hunk,               "Stage hunk")
        map("<leader>gr", gs.reset_hunk,               "Reset hunk")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
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
