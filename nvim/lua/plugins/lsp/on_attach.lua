-- File: ~/.config/nvim/lua/plugins/lsp/on_attach.lua

local function on_attach(client, bufnr)
  -- Enable completion for the buffer
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Keybindings for LSP
  local opts = { noremap = true, silent = true }
  
  -- Use a helper function for keymaps
  local keymap = vim.keymap.set

  keymap('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap('n', 'gd', vim.lsp.buf.definition, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)
  keymap('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', 'gr', vim.lsp.buf.references, opts)
  keymap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end

return on_attach
