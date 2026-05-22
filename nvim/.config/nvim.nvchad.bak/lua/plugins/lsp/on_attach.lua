local function on_attach(_, bufnr)
  local buf_map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Vim-style LSP navigation (keep as fallbacks)
  buf_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  buf_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  buf_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  buf_map("n", "gr", vim.lsp.buf.references, "Find References")
  buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

  -- CLion-inspired (GNOME Terminal compatible)
  buf_map("n", "<C-b>", vim.lsp.buf.definition, "Go to Definition")
  buf_map("n", "<A-CR>", vim.lsp.buf.code_action, "Quick Fix")
  buf_map("i", "<C-p>", vim.lsp.buf.signature_help, "Parameter Info")

  -- Call hierarchy
  buf_map("n", "<leader>ci", vim.lsp.buf.incoming_calls, "Incoming Calls")
  buf_map("n", "<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

  -- Type definition
  buf_map("n", "<leader>ct", vim.lsp.buf.type_definition, "Type Definition")

  -- Signature help (avoid <C-k> which conflicts with tmux-navigator)
  buf_map("n", "<leader>ck", vim.lsp.buf.signature_help, "Signature Help")
  buf_map("i", "<C-S-k>", vim.lsp.buf.signature_help, "Signature Help")

  -- Telescope symbol search
  buf_map("n", "<leader>ss", "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols")
  buf_map("n", "<leader>sd", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
end

return on_attach
