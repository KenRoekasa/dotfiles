-- CMake integration (overrides LazyVim's cmake extra defaults)
return {
  -- CLion-style bottom panel: configure / build / run / terminal tabs
  -- with clickable winbar, stop button, recent targets, command queue.
  {
    name = 'cmake-panel',
    dir = vim.fn.stdpath('config') .. '/lua',
    lazy = false,
    keys = {
      { '<S-F12>', function() require('cmake_panel').configure() end,                     desc = 'CMake Configure' },
      { '<S-F11>', function() require('cmake_panel').build() end,                         desc = 'CMake Build All' },
      { '<S-F9>',  function() require('cmake_panel').run_last() end,                      desc = 'CMake Build + Run Last Target' },
      { '<A-F12>', function() require('cmake_panel').show_terminal({ focus = true }) end,  desc = 'CMake Terminal' },
      { '<leader>cs', function() require('cmake_panel').select_target() end,              desc = '[C]Make [S]elect Target' },
      { '<leader>cr', function() require('cmake_panel').run_last() end,                   desc = '[C]Make [R]e-run Last Target' },
      { '<leader>co', function() require('cmake_panel').toggle_panel() end,               desc = '[C]Make Toggle Panel' },
      { '<leader>cX', function() require('cmake_panel').stop_current() end,               desc = '[C]Make Stop Job' },
    },
    config = function()
      vim.cmd([[
        function! CmakePanelWinbar() abort
          try
            return luaeval("require('cmake_panel').winbar()")
          catch
            return ''
          endtry
        endfunction
      ]])
      vim.opt.winbar = '%{%CmakePanelWinbar()%}'
    end,
  },

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
