-- Testing: neotest with CTest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "orjangj/neotest-ctest",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
    },
    config = function()
      local ctest_root_pattern = require("neotest.lib").files.match_root_pattern(
        "CMakePresets.json",
        "compile_commands.json",
        ".git"
      )

      require("neotest").setup({
        adapters = {
          require("neotest-ctest").setup({
            root = function(dir)
              return ctest_root_pattern(dir)
            end,
            is_test_file = function(file_path)
              local supported = { cpp = true, cc = true, cxx = true }
              local ext = file_path:match("%.(%w+)$")
              if not ext or not supported[ext] then
                return false
              end
              local name = file_path:match("([^/]+)%.[^.]+$"):lower()
              return name:find("test") ~= nil
            end,
            filter_dir = function(name)
              local exclude = {
                build = true, bin = true, lib = true, out = true,
                cmake = true, CMakeFiles = true, Testing = true,
                doc = true, docs = true, examples = true,
                scripts = true, tools = true, venv = true,
                external_deps = true, patches = true,
                ["_deps"] = true,
              }
              if exclude[name] then return false end
              if name:find("^cmake%-build%-") then return false end
              return true
            end,
            frameworks = { "catch2", "gtest", "doctest" },
          }),
        },
      })
    end,
  },
}
