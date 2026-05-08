return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        file_ignore_patterns = {
          "cmake%-build%-[^/]*",
        },
        cwd = vim.uv.cwd() or vim.fn.expand("~"),
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            mirror = true,
            prompt_position = "top",
            preview_cutoff = 0,
            preview_height = 0.4,
          },
        },
      })
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          cwd = vim.uv.cwd() or vim.fn.expand("~"),
        },
        live_grep = {
          cwd = vim.uv.cwd() or vim.fn.expand("~"),
        },
      })
      return opts
    end,
  },
}
