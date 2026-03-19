require "nvchad.autocmds"

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
