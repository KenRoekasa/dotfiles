return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          bigfile = { enabled = true },
          quickfile = { enabled = true },
        },
      },
    },
    keys = {
      { "<leader>ac", desc = "Toggle Claude Code" },
      { "<leader>af", desc = "Focus Claude Code" },
      { "<leader>ar", desc = "Resume Claude Code" },
      { "<leader>as", mode = "v", desc = "Send to Claude Code" },
      { "<leader>aa", desc = "Accept diff" },
      { "<leader>ad", desc = "Deny diff" },
    },
    config = function()
      require("claudecode").setup()

      vim.keymap.set("n", "<leader>ac", function()
        require("claudecode").toggle()
      end, { desc = "Toggle Claude Code" })

      vim.keymap.set("n", "<leader>af", function()
        require("claudecode").focus()
      end, { desc = "Focus Claude Code" })

      vim.keymap.set("n", "<leader>ar", function()
        require("claudecode").resume()
      end, { desc = "Resume Claude Code" })

      vim.keymap.set("v", "<leader>as", function()
        require("claudecode").send_selection()
      end, { desc = "Send selection to Claude Code" })

      vim.keymap.set("n", "<leader>aa", function()
        require("claudecode.diff").accept()
      end, { desc = "Accept diff" })

      vim.keymap.set("n", "<leader>ad", function()
        require("claudecode.diff").deny()
      end, { desc = "Deny diff" })
    end,
  },
}
