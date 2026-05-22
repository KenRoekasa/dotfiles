-- Debugging: keep GDB adapter alongside codelldb (LazyVim's dap.core provides codelldb)
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- GDB adapter (CLion-bundled GDB with DAP support)
      dap.adapters.gdb = {
        type = "executable",
        command = vim.fn.expand("~/.local/share/JetBrains/Toolbox/apps/clion/bin/gdb/linux/x64/bin/gdb"),
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      -- Add GDB as an additional C/C++ debug config
      local gdb_config = {
        name = "Launch (GDB)",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = true,
      }

      -- Append to existing configurations (don't overwrite codelldb ones from LazyVim)
      dap.configurations.cpp = dap.configurations.cpp or {}
      table.insert(dap.configurations.cpp, gdb_config)
      dap.configurations.c = dap.configurations.c or {}
      table.insert(dap.configurations.c, gdb_config)
    end,
  },

  -- Inline variable values while debugging
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = { virt_text_pos = "inline" },
  },
}
