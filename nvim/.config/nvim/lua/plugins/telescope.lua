return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        file_ignore_patterns = {
          "cmake%-build%-[^/]*",
        },
      })
      return opts
    end,
  },
}
