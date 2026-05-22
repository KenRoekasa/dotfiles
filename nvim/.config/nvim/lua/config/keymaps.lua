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

-- CLion-style shortcuts
map("n", "<F2>", function() vim.diagnostic.goto_next() end, { desc = "Next Error" })
map("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, { desc = "Previous Error" })
map("n", "<F4>", function() vim.lsp.buf.definition() end, { desc = "Jump to Source" })
map("n", "<A-1>", function() Snacks.explorer() end, { desc = "Project (file tree)" })
map("n", "<A-4>", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems" })
map("n", "<A-7>", "<cmd>AerialToggle<CR>", { desc = "Structure (outline)" })
map("n", "<C-S-n>", "<cmd>FzfLua files<CR>", { desc = "Go to File (Ctrl+Shift+N)" })
map("n", "<C-S-f>", "<cmd>FzfLua live_grep<CR>", { desc = "Find in Path (Ctrl+Shift+F)" })

-- Cheatsheet: open in a floating window
map("n", "<leader>?", function()
  local cheatsheet = vim.fn.stdpath("config"):gsub("/.config/nvim$", "") .. "/CHEATSHEET.md"
  if vim.fn.filereadable(cheatsheet) == 0 then
    cheatsheet = vim.fn.expand("~/dotfiles/nvim/CHEATSHEET.md")
  end
  vim.cmd("split " .. cheatsheet)
  vim.bo.bufhidden = "wipe"
  vim.bo.modifiable = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
end, { desc = "Open Cheatsheet" })
