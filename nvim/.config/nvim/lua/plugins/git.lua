return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      current_line_blame = false, -- toggle with <leader>gb
      current_line_blame_opts = {
        virt_text = true,
        delay = 300,
      },
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation
        map("n", "]h", gs.next_hunk,              "Next hunk")
        map("n", "[h", gs.prev_hunk,              "Prev hunk")

        -- Hunk actions
        map("n", "<leader>ghs", gs.stage_hunk,    "Stage hunk")
        map("n", "<leader>ghr", gs.reset_hunk,    "Reset hunk")
        map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
        map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
        map("n", "<leader>ghp", gs.preview_hunk,  "Preview hunk")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")

        -- Blame
        map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
      end,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit Status" },
      { "<A-9>",      "<cmd>Neogit<CR>", desc = "Git" },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      {
        "<A-0>",
        function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            vim.cmd("DiffviewClose")
          else
            vim.cmd("DiffviewOpen")
          end
        end,
        desc = "Toggle Diffview",
      },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Branch history" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>",         desc = "Close diff view" },
    },
    opts = {
      keymaps = {
        view = {
          { "n", "<C-o>", function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
          { "n", "<F4>",  function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
        },
        file_panel = {
          { "n", "<F4>", function() require("diffview.actions").goto_file_edit() end, { desc = "Open source file" } },
        },
        file_history_panel = {
          { "n", "<C-o>", function() require("diffview.actions").open_in_diffview() end, { desc = "Open in diff" } },
          { "n", "<F4>",  function() require("diffview.actions").open_in_diffview() end, { desc = "Open in diff" } },
        },
      },
      view = {
        diff        = { winbar_info = true },
        file_history = { winbar_info = true },
      },
      hooks = {
        diff_buf_read = function()
          vim.opt_local.scrollbind = true
          vim.opt_local.cursorbind = true
        end,
      },
    },
  },
}
