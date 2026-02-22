require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Search
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })
map("n", "<leader>sa", "<cmd>Telescope commands<CR>", { desc = "Search commands" })

-- CMake
map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "Build" })
map("n", "<leader>cc", "<cmd>CMakeGenerate<CR>", { desc = "CMake generate" })
map("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "Run" })

-- Which-key group labels
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.add({
    { "<leader>a", group = "Claude Code" },
    { "<leader>c", group = "Code/LSP/CMake" },
    { "<leader>d", group = "Debug" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>q", group = "Session" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Test" },
    { "<leader>x", group = "Diagnostics" },
  })
end
