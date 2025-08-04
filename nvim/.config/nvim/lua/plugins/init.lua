return {
  -- General utilities
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Completion: LSP source
  { "hrsh7th/cmp-nvim-lsp" },

  -- Mason & LSP installer
  {
	  "mason-org/mason-lspconfig.nvim",
	  opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "cmake_language_server",
      },
    },
	  dependencies = {
		  { "mason-org/mason.nvim", opts = {} },
		  "neovim/nvim-lspconfig",
	  },
  },
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang_format" },
          cpp = { "clang_format" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 5000 })
      end, { desc = "Format file or range (conform)" })
    end,
  },


  -- LSPConfig setup
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local buf_map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        buf_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        buf_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        buf_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        buf_map("n", "gr", vim.lsp.buf.references, "Find References")
        buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      end

      -- Register language servers
      lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })

      lspconfig.ts_ls.setup({
	      on_attach = on_attach,
	      capabilities = capabilities,
      })
    end,
  },


  -- Header/source switch
  {
    "jakemason/ouroboros.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("ouroboros").setup({})
      vim.keymap.set("n", "<leader>o", ":Ouroboros<CR>", { desc = "Switch header/source" })
    end,
  },

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
      }
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      }

      -- Keybindings
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
      vim.keymap.set("n", "<leader>dss", dap.session, { desc = "DAP: Show Session" })
    end,
  },
}

