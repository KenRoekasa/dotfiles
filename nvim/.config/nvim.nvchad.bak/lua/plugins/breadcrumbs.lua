return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      lsp = { auto_attach = true },
      highlight = true,
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "LspAttach",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
