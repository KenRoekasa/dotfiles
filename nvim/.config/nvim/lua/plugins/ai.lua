-- AI assistants: Copilot + Claude Code
return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true

      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Copilot: Accept suggestion",
      })
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss suggestion" })
      vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Copilot: Open panel" })
    end,
  },

  -- Claude Code
  {
    "coder/claudecode.nvim",
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

      vim.keymap.set("n", "<leader>ac", function() require("claudecode").toggle() end, { desc = "Toggle Claude Code" })
      vim.keymap.set("n", "<leader>af", function() require("claudecode").focus() end, { desc = "Focus Claude Code" })
      vim.keymap.set("n", "<leader>ar", function() require("claudecode").resume() end, { desc = "Resume Claude Code" })
      vim.keymap.set("v", "<leader>as", function() require("claudecode").send_selection() end, { desc = "Send selection to Claude Code" })
      vim.keymap.set("n", "<leader>aa", function() require("claudecode.diff").accept() end, { desc = "Accept diff" })
      vim.keymap.set("n", "<leader>ad", function() require("claudecode.diff").deny() end, { desc = "Deny diff" })
    end,
  },
}
