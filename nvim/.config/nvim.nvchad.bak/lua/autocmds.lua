require "nvchad.autocmds"

-- Middle-click on tabufline to close buffer
vim.keymap.set("n", "<MiddleMouse>", function()
  local mousepos = vim.fn.getmousepos()
  -- Only act on clicks in the tabline (line 0)
  if mousepos.screenrow == 1 then
    -- Click the tab first to switch to that buffer, then close it
    vim.api.nvim_input("<LeftMouse>")
    vim.schedule(function()
      require("nvchad.tabufline").close_buffer()
    end)
  else
    -- Normal middle-click paste behavior elsewhere
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<MiddleMouse>", true, false, true), "n", false)
  end
end, { desc = "Middle-click close buffer tab" })

-- Auto-collapse #include blocks when opening C/C++ files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      buffer = args.buf,
      once = true,
      callback = function()
        vim.defer_fn(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then return end
          local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
          local first, last = nil, nil
          for i, line in ipairs(lines) do
            if line:match("^%s*#%s*include") then
              if not first then first = i end
              last = i
            elseif first and not line:match("^%s*$") then
              break
            end
          end
          if first and last and last > first then
            vim.api.nvim_win_set_cursor(0, { first, 0 })
            vim.cmd(first .. "," .. last .. "fold")
          end
        end, 100)
      end,
    })
  end,
})
