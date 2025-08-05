require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })


map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "Build" })
map("n", "<leader>cc", "<cmd>CMakeGenerate<CR>", { desc = "Cmake generator" })
map("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "Run" })



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
