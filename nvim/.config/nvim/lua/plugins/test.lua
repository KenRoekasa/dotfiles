return {
  -- Core Neotest plugin definition
  {
    "nvim-neotest/neotest",
    -- Essential dependencies for CTest/C++
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "orjangj/neotest-ctest", -- Required for CTest/CMake
    },
    -- Configuration function
    config = function()
      -- Define the simplest root detection: checks for a CMakeLists file or a Git repo
      local ctest_root_pattern = require("neotest.lib").files.match_root_pattern(
        "CMakeLists.txt",          -- The most definitive marker for a CMake project root
        "compile_commands.json",   -- Another strong CMake/LSP marker
        ".git"                     -- The Git repository root
      )

      require("neotest").setup({
        -- The neotest-ctest adapter is used to handle all CTest-driven frameworks like Catch2
        adapters = {
          require("neotest-ctest").setup({
            build_dir_name = "cmake-build-debug", -- Must match your actual build folder name

            root = function(dir)
              return ctest_root_pattern(dir)
            end,

            -- Simplifies the test file check to be case-insensitive (checks for "test" anywhere in the filename)
            is_test_file = function(file)
              return string.find(string.lower(file), "test") ~= nil
            end,

            -- Explicitly specify Catch2 (and others) so CTest knows what to look for
            frameworks = { "catch2", "gtest", "doctest" },
          }),
        },
      })
    end,
  },
}
