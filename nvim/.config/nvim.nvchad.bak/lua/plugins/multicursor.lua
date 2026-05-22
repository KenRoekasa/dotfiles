return {
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    init = function()
      -- Alt+j/k to add cursor below/above (CLion/VSCode style)
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<M-j>",
        ["Add Cursor Up"]   = "<M-k>",
        ["Find Under"]      = "<M-d>",  -- select next occurrence (like Ctrl+d in VSCode)
        ["Find Subword Under"] = "<M-d>",
      }
    end,
  },
}
