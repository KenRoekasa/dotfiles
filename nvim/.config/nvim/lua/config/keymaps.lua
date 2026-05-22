-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Format on save toggle
vim.g.format_on_save = true
map("n", "<leader>tf", function()
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify("Format on save: " .. (vim.g.format_on_save and "ON" or "OFF"), vim.log.levels.INFO)
end, { desc = "Toggle format on save" })

-- Navigation (Ctrl+click to definition)
map("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
map("n", "<A-Left>", "<C-o>", { desc = "Navigate Back" })
map("n", "<A-Right>", "<C-i>", { desc = "Navigate Forward" })
