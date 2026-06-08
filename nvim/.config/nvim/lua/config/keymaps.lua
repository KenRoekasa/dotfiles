-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

----------------------------------------------------------------------
-- Navigation
----------------------------------------------------------------------
-- Ctrl+click → go to definition (CLion / VSCode muscle memory)
map("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
-- Alt+Left/Right → jump-list back/forward (browser-style)
map("n", "<A-Left>",  "<C-o>", { desc = "Navigate Back" })
map("n", "<A-Right>", "<C-i>", { desc = "Navigate Forward" })

----------------------------------------------------------------------
-- CLion-style F-keys & Alt-numbers
----------------------------------------------------------------------
map("n", "<F2>",   function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
map("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })
map("n", "<F4>",   function() vim.lsp.buf.definition() end,   { desc = "Jump to Source" })
map("n", "<A-1>",  function() Snacks.explorer() end,          { desc = "File Tree" })
map("n", "<A-2>",  function() Snacks.terminal() end,          { desc = "Terminal" })
map("t", "<A-2>",  function() Snacks.terminal() end,          { desc = "Terminal" })
map("n", "<A-4>",  "<cmd>Trouble diagnostics toggle<cr>",     { desc = "Problems" })
map("n", "<A-7>",  "<cmd>AerialToggle<CR>",                   { desc = "Structure (outline)" })

----------------------------------------------------------------------
-- IDE-style search (Ctrl+Shift+F = Find in Path)
-- Note: <leader>fg overrides are in plugins/ui.lua to beat LazyVim defaults
----------------------------------------------------------------------
map("n", "<C-S-f>", "<cmd>FzfLua live_grep<CR>",   { desc = "Find in Path" })
map("x", "<C-S-f>", "<cmd>FzfLua grep_visual<CR>", { desc = "Grep Selection" })

----------------------------------------------------------------------
-- Cheatsheet
----------------------------------------------------------------------
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
