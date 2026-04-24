return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%d-%m-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
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
      keymaps = {
        view = {
          { "n", "<C-o>", function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
          { "n", "<F4>",  function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
        },
        file_panel = {
          { "n", "<F4>",  function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
        },
        file_history_panel = {
          { "n", "<C-o>", function() require("diffview.actions").open_in_diffview() end, { desc = "Open in diff" } },
          { "n", "<F4>",  function() require("diffview.actions").open_in_diffview() end, { desc = "Open in diff" } },
        },
      },
      view = {
        diff = {
          winbar_info = true,
        },
        file_history = {
          winbar_info = true,
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          vim.opt_local.scrollbind = true
          vim.opt_local.cursorbind = true
        end,
      },
    },
  },
}
