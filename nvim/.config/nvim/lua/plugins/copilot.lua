return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default <Tab> mapping so it doesn't conflict with cmp
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
}
