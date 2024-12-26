-- gc<motion> to comment out code via comment.nvim
-- ctrl-space to do treesitter based incremental selection, backspace to reduce

vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil file manager" })

keymap.set("n", "<Tab>", "<cmd>:bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>:bprev<CR>", { desc = "Prev buffer" })

-- Treewalker
vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-j>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-k>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true })
