-- Consolidated "find" prefix: all picker/search functionality lives under <leader>f.
-- Disables LazyVim's default <leader>s* picker keys and reassigns them under <leader>f*.
-- See HOTKEYS.md (section "Neovim — Find (<leader>f)") for the full reference.

local symbols_filter = function(entry, ctx)
  if ctx.symbol_query then
    return entry.text:lower():find(ctx.symbol_query, 1, true) ~= nil
  end
  return true
end

return {
  -- which-key: label the f-prefix as the "find" group
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>f", group = "find", icon = "" },
      },
    },
  },

  -- fzf-lua pickers: move all <leader>s* picker keys to <leader>f*
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- Disable LazyVim's default <leader>s* picker bindings
      { '<leader>s"', false },
      { "<leader>s/", false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>sw", false, mode = "x" },
      { "<leader>sW", false, mode = "x" },
      { "<leader>ss", false },
      { "<leader>sS", false },

      -- Vim internals
      { '<leader>f"', "<cmd>FzfLua registers<cr>",            desc = "Registers" },
      { "<leader>f/", "<cmd>FzfLua search_history<cr>",       desc = "Search History" },
      { "<leader>f;", "<cmd>FzfLua command_history<cr>",      desc = "Command History" },
      { "<leader>f'", "<cmd>FzfLua marks<cr>",                desc = "Marks" },
      { "<leader>fa", "<cmd>FzfLua commands<cr>",             desc = "Commands (action)" },
      { "<leader>fA", "<cmd>FzfLua autocmds<cr>",             desc = "Auto Commands" },

      -- Diagnostics
      { "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics (workspace)" },
      { "<leader>fD", "<cmd>FzfLua diagnostics_document<cr>",  desc = "Diagnostics (buffer)" },

      -- Grep variants (fg from ui.lua stays = Live Grep root)
      { "<leader>fG", LazyVim.pick("live_grep", { root = false }), desc = "Live Grep (cwd)" },
      { "<leader>fw", LazyVim.pick("grep_cword"),                  desc = "Word (root)" },
      { "<leader>fW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>fw", LazyVim.pick("grep_visual"),                 desc = "Selection (root)", mode = "x" },
      { "<leader>fW", LazyVim.pick("grep_visual", { root = false }), desc = "Selection (cwd)", mode = "x" },

      -- Help / Reference
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>",  desc = "Help Pages" },
      { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Highlight Groups" },
      { "<leader>fM", "<cmd>FzfLua man_pages<cr>",  desc = "Man Pages" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>",    desc = "Keymaps" },

      -- Lists
      { "<leader>fj", "<cmd>FzfLua jumps<cr>",      desc = "Jumplist" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>",   desc = "Quickfix List" },
      { "<leader>fL", "<cmd>FzfLua loclist<cr>",    desc = "Location List" },
      { "<leader>fl", "<cmd>FzfLua lines<cr>",      desc = "Buffer Lines" },

      -- Symbols
      {
        "<leader>fs",
        function() require("fzf-lua").lsp_document_symbols({ regex_filter = symbols_filter }) end,
        desc = "Symbols (document)",
      },
      {
        "<leader>fS",
        function() require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = symbols_filter }) end,
        desc = "Symbols (workspace)",
      },

      -- Resume the last picker
      { "<leader>fp", "<cmd>FzfLua resume<cr>", desc = "Resume Picker" },
    },
  },

  -- todo-comments: move <leader>st/sT to <leader>ft/fT
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },
      { "<leader>ft", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
      {
        "<leader>fT",
        function() require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- grug-far: move <leader>sr/sw to <leader>fx/fX (search & replace)
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", false },
      { "<leader>sw", false },
      { "<leader>fx", function() require("grug-far").open() end, desc = "Search & Replace (grug-far)" },
      {
        "<leader>fX",
        function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
        desc = "Search & Replace Word",
      },
    },
  },
}
