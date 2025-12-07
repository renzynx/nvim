require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force Quit" })
map("n", "<leader>xq", "<cmd>qa!<CR>", { desc = "Force Quit Neovim" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
