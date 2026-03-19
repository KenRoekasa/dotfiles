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

			  -- Call hierarchy
			  buf_map("n", "<leader>ci", vim.lsp.buf.incoming_calls, "Incoming Calls")
			  buf_map("n", "<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

			  -- Type definition
			  buf_map("n", "<leader>ct", vim.lsp.buf.type_definition, "Type Definition")

			  -- Signature help
			  buf_map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
			  buf_map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

			  -- Telescope symbol search
			  buf_map("n", "<leader>ss", "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols")
			  buf_map("n", "<leader>sd", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
		  end

		  -- Register language servers
		  vim.lsp.enable({ "clangd", "pyright", "cmake" })

		  vim.api.nvim_create_autocmd("LspAttach", {
			  callback = function(args)
				  local client = vim.lsp.get_client_by_id(args.data.client_id)
				  on_attach(client, args.buf)
			  end,
		  })

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
      }
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
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- GDB adapter (native)
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
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

      -- Keybindings
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "\b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
      vim.keymap.set("n", "<leader>dss", dap.session, { desc = "DAP: Show Session" })
    end,
  },
  {
	 "github/copilot.vim"
  },

  -- Git UI
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
          telescope = true,
        },
      })
      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit Status" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup()
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview Open" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview File History" })
      vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview Branch History" })
      vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Diffview Close" })
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}

