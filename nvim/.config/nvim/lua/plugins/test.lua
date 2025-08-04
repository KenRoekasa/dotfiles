return {
  -- Core Neotest plugin
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "alfaix/neotest-gtest"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-gtest").setup({})
        }
      })
    end
  }
}
