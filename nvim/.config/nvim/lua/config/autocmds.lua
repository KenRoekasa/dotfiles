-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Middle-click on bufferline to close buffer
vim.keymap.set("n", "<MiddleMouse>", function()
  local mousepos = vim.fn.getmousepos()
  if mousepos.screenrow == 1 then
    vim.api.nvim_input("<LeftMouse>")
    vim.schedule(function()
      vim.cmd("bd")
    end)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<MiddleMouse>", true, false, true), "n", false)
  end
end, { desc = "Middle-click close buffer tab" })
