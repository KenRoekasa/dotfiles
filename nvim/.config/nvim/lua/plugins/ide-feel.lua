-- IDE-feel plugins that LazyVim doesn't ship by default
return {
  -- Breadcrumbs (CLion navigation bar)
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
  },

  -- Code action lightbulb (💡 in sign column)
  {
    "kosayoda/nvim-lightbulb",
    version = "*",
    event = "LspAttach",
    opts = { autocmd = { enabled = true } },
  },

  -- Scrollbar with diagnostics/git markers
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    opts = { handlers = { gitsigns = true, search = true } },
  },

  -- Reference/def/impl counts above symbols (CLion code vision)
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- Persistent DAP breakpoints
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "VeryLazy",
    opts = { load_breakpoints_event = { "BufReadPost" } },
  },

  -- Modern folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    opts = {
      provider_selector = function(_, filetype)
        if filetype == "" then
          return ""
        end
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },

  -- Better vim.ui.select/input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },
}
