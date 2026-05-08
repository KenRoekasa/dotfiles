require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- ── Tool windows ─────────────────────────────────────────────────
map("n", "<A-1>", "<cmd>NvimTreeToggle<CR>",             { desc = "Project (file tree)" })
map("n", "<A-7>", "<cmd>AerialToggle<CR>",               { desc = "Structure (outline)" })
map("n", "<A-4>", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems" })
map("n", "<leader>tm", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })

-- ── Navigation ───────────────────────────────────────────────────
map("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
map("n", "<A-Left>", "<C-o>", { desc = "Navigate Back" })
map("n", "<A-Right>", "<C-i>", { desc = "Navigate Forward" })
map("n", "<F2>", function() vim.diagnostic.goto_next() end, { desc = "Next Error" })
map("n", "<leader>xp", function() vim.diagnostic.goto_prev() end, { desc = "Previous Error" })

-- ── Search / Find ────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Go to File" })
map("n", "<leader>fp", "<cmd>Telescope find_files<CR>", { desc = "Go to File (alt)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find in Path" })
map("n", "<C-S-n>", "<cmd>Telescope find_files<CR>", { desc = "Search file names (CLion Ctrl+Shift+N)" })
map("n", "<C-S-N>", "<cmd>Telescope find_files<CR>", { desc = "Search file names (CLion Ctrl+Shift+N)" })
map("n", "<C-S-f>", "<cmd>Telescope live_grep<CR>", { desc = "Find in path (CLion Ctrl+Shift+F)" })
map("n", "<C-S-F>", "<cmd>Telescope live_grep<CR>", { desc = "Find in path (CLion Ctrl+Shift+F)" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Grep word under cursor" })
map("v", "<leader>fg", function()
  local text = vim.getregion(vim.fn.getpos "v", vim.fn.getpos ".", { type = vim.fn.mode() })
  local query = table.concat(text, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
  require("telescope.builtin").grep_string({ search = query })
end, { desc = "Grep selection" })
map("n", "<leader>fa", "<cmd>Telescope commands<CR>", { desc = "Find Action" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Search Keymaps" })

-- ── Git ──────────────────────────────────────────────────────────
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>",   { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gl", "<cmd>Telescope git_commits<CR>",  { desc = "Git log" })

-- ── Build ────────────────────────────────────────────────────────
map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "Build" })
map("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "Run" })
map("n", "<leader>cc", "<cmd>CMakeGenerate<CR>", { desc = "CMake Generate" })

-- ── Markdown ─────────────────────────────────────────────────────
map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })

-- Which-key group labels
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.add({
    { "<leader>a", group = "Claude Code" },
    { "<leader>c", group = "Code/LSP/CMake" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>q", group = "Session" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Test/Terminal" },
    { "<leader>x", group = "Diagnostics" },
  })
end
