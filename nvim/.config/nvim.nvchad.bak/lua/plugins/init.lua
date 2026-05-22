return {
  -- General utilities
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      local clang_format = vim.fn.executable("clang-format") == 1 and { "clang_format" } or {}

      vim.g.format_on_save = true

      require("conform").setup({
        formatters_by_ft = {
          c = clang_format,
          cpp = clang_format,
          lua = { "stylua" },
        },
        format_on_save = function()
          if not vim.g.format_on_save then return end
          return { timeout_ms = 2000, lsp_fallback = true }
        end,
      })

      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 5000 })
      end, { desc = "Reformat Code" })

      vim.keymap.set("n", "<leader>tf", function()
        vim.g.format_on_save = not vim.g.format_on_save
        vim.notify("Format on save: " .. (vim.g.format_on_save and "ON" or "OFF"), vim.log.levels.INFO)
      end, { desc = "Toggle format on save" })
    end,
  },


  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "cpp", "lua", "cmake", "python", "markdown", "markdown_inline" },
      auto_install = true,
    },
  },

  -- Header/source switch
  {
    "jakemason/ouroboros.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("ouroboros").setup({})
      vim.keymap.set("n", "<leader>o", ":Ouroboros<CR>", { desc = "Switch header/source" })
      vim.keymap.set("n", "<F10>", ":Ouroboros<CR>", { desc = "Switch header/source" })
    end,
  },

  -- terminal
 {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- Debugging (DAP)
  {
    "mfussenegger/nvim-dap",
    ft = { "c", "cpp", "objc", "objcpp" },
    dependencies = {
      {
	      "rcarriga/nvim-dap-ui",
	      dependencies = {
		      {
			      "theHamsta/nvim-dap-virtual-text",
			      config = function()
				      require("nvim-dap-virtual-text").setup()
			      end,
		      }
	      },
	      config = function()
		      require("dapui").setup()
	      end,
      },
      {
	 "nvim-neotest/nvim-nio"
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
          ensure_installed = { "codelldb" },
        },
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- CodeLLDB adapter
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        host = "127.0.0.1",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
        timeout = 600000,
      }

      -- GDB adapter (CLion-bundled GDB 16.3 with DAP support)
      dap.adapters.gdb = {
        type = "executable",
        command = vim.fn.expand("~/.local/share/JetBrains/Toolbox/apps/clion/bin/gdb/linux/x64/bin/gdb"),
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.configurations.cpp = {
        {
          name = "Launch (CodeLLDB)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = true,
        },
      }

      -- C files use the same debug configurations as C++
      dap.configurations.c = dap.configurations.cpp

      -- Debug keybindings (plain F-keys + leader for GNOME Terminal)
      vim.keymap.set("n", "<F9>", dap.continue, { desc = "DAP: Resume / Start" })
      vim.keymap.set("n", "<F7>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F8>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "DAP: Stop" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "DAP: Evaluate Expression" })
      vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
    end,
  },
  -- Code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    config = function()
      require("ufo").setup({
        open_fold_hl_timeout = 0,
        provider_selector = function(_, filetype)
          if filetype == "nvdash" or filetype == "" then
            return ""
          end
          return { "treesitter", "indent" }
        end,
      })

      -- Open all folds when a buffer is opened
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          require("ufo").openAllFolds()
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft ~= "nvdash" and ft ~= "" then
            vim.wo.foldcolumn = "1"
            vim.wo.foldenable = true
          end
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zK", function()
        require("ufo").peekFoldedLinesUnderCursor()
      end, { desc = "Peek fold" })
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  -- Markdown preview in browser (supports mermaid diagrams)
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },
}

