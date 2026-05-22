return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory (Oil)" },
      { "<leader>-", function() require("oil").open(vim.fn.getcwd()) end, desc = "Open cwd (Oil)" },
    },
    opts = {
      default_file_explorer = false, -- keep NvimTree as default
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-s>"] = false, -- don't override split
      },
    },
  },
}
