return {
  -- Core Neotest plugin
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "alfaix/neotest-gtest",
      "orjangj/neotest-ctest"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-gtest").setup({}),
          require("neotest-ctest").setup({
            root = function(dir)
              return require("neotest.lib").files.match_root_pattern(
                "CMakePresets.json",
                "compile_commands.json",
                ".clangd",
                ".clang-format",
                ".clang-tidy",
                "build",
                "out",
                ".git"
              )(dir)
            end,
            is_test_file = function(file)
              local is_cpp = file.ext == ".cpp" or file.ext == ".cc" or file.ext == ".cxx"
              local has_test_in_name = string.find(file.stem, "Test") ~= nil
              return is_cpp and has_test_in_name
            end,
            frameworks = { "gtest", "catch2", "doctest", "cpputest"},

          })
        }
      })
    end
  }
}
