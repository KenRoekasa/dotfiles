-- CMake integration (overrides LazyVim's cmake extra defaults)
return {
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_use_preset = true,
      cmake_regenerate_on_save = true,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_directory = function()
        return "out/${variant:buildType}"
      end,
      cmake_compile_commands_options = { action = "soft_link" },
      cmake_executor = { name = "quickfix" },
      cmake_runner = { name = "toggleterm", opts = { direction = "horizontal" } },
      cmake_dap_configuration = {
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = false,
      },
      cmake_notifications = { runner = { enabled = true }, executor = { enabled = true } },
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cR", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "Select Build Target" },
      { "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "Select Launch Target" },
      { "<leader>cT", "<cmd>CMakeSelectBuildType<cr>", desc = "Select Build Type" },
      { "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "Select Configure Preset" },
      { "<leader>cB", "<cmd>CMakeSelectBuildPreset<cr>", desc = "Select Build Preset" },
      { "<leader>ck", "<cmd>CMakeSelectKit<cr>", desc = "Select Kit" },
      { "<leader>cx", "<cmd>CMakeLaunchArgs<cr>", desc = "Set Launch Args" },
      { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
    },
  },
}
