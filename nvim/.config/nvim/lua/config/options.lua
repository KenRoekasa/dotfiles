-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
vim.opt.showtabline = 2  -- always show tab bar

-- Auto-save on focus lost (toggleable)
vim.g.autosave_on_focus_lost = false

local autosave_group = vim.api.nvim_create_augroup("AutoSaveFocusLost", { clear = true })

local function set_autosave(enabled)
  vim.g.autosave_on_focus_lost = enabled
  vim.api.nvim_clear_autocmds({ group = autosave_group })
  if enabled then
    vim.api.nvim_create_autocmd("FocusLost", {
      group = autosave_group,
      callback = function()
        vim.cmd("silent! wa")
      end,
    })
    vim.notify("Autosave: ON", vim.log.levels.INFO)
  else
    vim.notify("Autosave: OFF", vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>ta", function()
  set_autosave(not vim.g.autosave_on_focus_lost)
end, { desc = "Toggle autosave on focus lost" })
