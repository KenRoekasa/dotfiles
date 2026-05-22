-- Multicursor and editing
return {
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    init = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<M-j>",
        ["Add Cursor Up"] = "<M-k>",
        ["Find Under"] = "<M-d>",
        ["Find Subword Under"] = "<M-d>",
      }
    end,
  },

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Flash for fast navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = true },
        search = { enabled = false },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- Oil.nvim for filesystem as buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory (Oil)" },
    },
    opts = {
      default_file_explorer = false,
      view_options = { show_hidden = true },
      keymaps = { ["q"] = "actions.close" },
    },
  },

  -- Search & replace
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", function() require("grug-far").open() end, desc = "Search & Replace (grug-far)" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search current word" },
    },
    opts = {},
  },

  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*", config = true },
}
