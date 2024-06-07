-- gc<motion> to comment out code via comment.nvim
-- ctrl-space to do treesitter based incremental selection, backspace to reduce

vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil file manager" })

keymap.set("n", "<Tab>", "<cmd>:bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>:bprev<CR>", { desc = "Prev buffer" })

-- window management
-- keymap.set("n", "<leader>s",
-- keymap.set("n", "<leader>sv", )
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
-- keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
