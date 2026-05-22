return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon: Add file",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon: Quick menu",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Harpoon: Previous file",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Harpoon: Next file",
      },
      {
        "<leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon: File 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon: File 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon: File 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon: File 4",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left (tmux/nvim)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down (tmux/nvim)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up (tmux/nvim)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (tmux/nvim)" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", function() require("grug-far").open() end, desc = "Search & Replace (grug-far)" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search current word (grug-far)" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, mode = "v", desc = "Search selection (grug-far)" },
    },
    opts = {},
  },
}
