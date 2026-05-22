return {
  -- Symbol outline (CLion: Structure tool window)
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      backends = { "treesitter", "lsp" },
      layout = {
        default_direction = "left",
        placement = "edge",
        width = 35,
      },
      attach_mode = "global",
      show_guides = true,
      filter_kind = {
        "Class", "Constructor", "Enum", "Function",
        "Interface", "Method", "Module", "Struct",
      },
    },
  },

  -- Sidebar layout manager (CLion: tool window sidebar)
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-tree.lua",
      "stevearc/aerial.nvim",
      "folke/trouble.nvim",
      "akinsho/toggleterm.nvim",
    },
    init = function()
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      animate = { enabled = false },
      wo = { winbar = true },
      left = {
        {
          title = "  Project",
          ft = "NvimTree",
          pinned = true,
          open = "NvimTreeOpen",
          size = { width = 35 },
        },
        {
          title = "  Structure",
          ft = "aerial",
          pinned = true,
          open = "AerialOpen",
          size = { width = 35 },
        },
      },
      bottom = {
        {
          title = "  Problems",
          ft = "trouble",
          size = { height = 12 },
          filter = function(buf)
            return vim.b[buf].trouble_preview ~= true
          end,
        },
        {
          title = "  Terminal",
          ft = "toggleterm",
          size = { height = 15 },
        },
      },
    },
  },
}
