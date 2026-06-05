-- Git: extend LazyVim defaults with diffview and gitsigns hunk keymaps
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        -- Navigate hunks; if at end/start of file's hunks, jump to next/prev buffer
        local function nav_hunk(direction)
          local hunks = gs.get_hunks()
          if not hunks or #hunks == 0 then
            vim.cmd(direction == "next" and "bnext" or "bprev")
            return
          end
          local line = vim.fn.line(".")
          if direction == "next" then
            local has_next = false
            for _, h in ipairs(hunks) do
              if h.added.start > line then has_next = true break end
            end
            if has_next then gs.nav_hunk("next") else vim.cmd("bnext") end
          else
            local has_prev = false
            for i = #hunks, 1, -1 do
              if hunks[i].added.start < line then has_prev = true break end
            end
            if has_prev then gs.nav_hunk("prev") else vim.cmd("bprev") end
          end
        end

        map("]h", function() nav_hunk("next") end, "Next hunk")
        map("[h", function() nav_hunk("prev") end, "Prev hunk")
        map("<leader>gh", gs.preview_hunk,             "Preview hunk")
        map("<leader>gs", gs.stage_hunk,               "Stage hunk")
        map("<leader>gr", gs.reset_hunk,               "Reset hunk")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
      {
        "<F7>", function()
          if vim.wo.diff then
            -- In diffview: ]c to next hunk, wrap to next file when at end
            local ok, lib = pcall(require, "diffview.lib")
            local in_diffview = ok and lib.get_current_view() ~= nil
            local before = vim.fn.line(".")
            vim.cmd("normal! ]c")
            if in_diffview then
              vim.schedule(function()
                if vim.fn.line(".") == before then
                  require("diffview.actions").select_next_entry()
                end
              end)
            end
          else
            require("gitsigns").nav_hunk("next", { wrap = false })
          end
        end, desc = "Next hunk",
      },
      {
        "<F19>", function()
          if vim.wo.diff then
            local ok, lib = pcall(require, "diffview.lib")
            local in_diffview = ok and lib.get_current_view() ~= nil
            local before = vim.fn.line(".")
            vim.cmd("normal! [c")
            if in_diffview then
              vim.schedule(function()
                if vim.fn.line(".") == before then
                  require("diffview.actions").select_prev_entry()
                end
              end)
            end
          else
            require("gitsigns").nav_hunk("prev", { wrap = false })
          end
        end, desc = "Prev hunk",
      },
      {
        "<S-F7>", function()
          if vim.wo.diff then
            local ok, lib = pcall(require, "diffview.lib")
            local in_diffview = ok and lib.get_current_view() ~= nil
            local before = vim.fn.line(".")
            vim.cmd("normal! [c")
            if in_diffview then
              vim.schedule(function()
                if vim.fn.line(".") == before then
                  require("diffview.actions").select_prev_entry()
                end
              end)
            end
          else
            require("gitsigns").nav_hunk("prev", { wrap = false })
          end
        end, desc = "Prev hunk",
      },
    },
    opts = {
      enhanced_diff_hl = true,
      use_icons        = true,
      show_help_hints  = true,
      view = {
        default      = { layout = "diff2_horizontal" },
        merge_tool   = { layout = "diff3_horizontal", disable_diagnostics = true },
        file_history = { layout = "diff2_horizontal" },
      },
      file_panel = {
        listing_style = "tree",
        tree_options  = { flatten_dirs = true, folder_statuses = "only_folded" },
        win_config    = { position = "left", width = 35 },
      },
      file_history_panel = {
        listing_style = "list",
        win_config    = { position = "bottom", height = 16 },
      },
      hooks = {
        diff_buf_read = function() vim.opt_local.cursorline = false end,
      },
    },
  },
}
