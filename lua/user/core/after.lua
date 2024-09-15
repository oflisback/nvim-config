local wk = require("which-key")
local telescope = require("telescope.builtin")

local keymap = vim.keymap

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

vim.api.nvim_command('command! ShowFilePath lua print(vim.fn.expand("%:p"))')

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit" },
	callback = function()
		vim.cmd.startinsert()
	end,
})

keymap.set("n", "gx", ":execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>", { desc = "Open url" })

keymap.set("n", "<C-h>", ":TmuxNavigateLeft<cr>")
keymap.set("n", "<C-j>", ":TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", ":TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", ":TmuxNavigateRight<cr>")

wk.add({
	{ "<leader>a", group = "assistant", mode = "n" },
	{ "<leader>af", "<cmd>GpChatFinder<cr>", desc = "Find chat" },
	{ "<leader>an", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat" },
	{ "<leader>ar", "<cmd>GpChatRespond<cr>", desc = "Respond" },
	{ "<leader>as", "<cmd>GpStop<cr>", desc = "Stop generation" },
	{ "<leader>at", "<cmd>GpChatToggle<cr>", desc = "Toggle" },
	{ "<leader>ae", ":AICommandExecute<cr>", desc = "Execute described command" },
	{ "<leader>ao", ":AICommandSuggest<cr>", desc = "Suggest described command" },

	{ "<leader>c", ":bd<CR>", desc = "Close current buffer" },
	{
		"<leader>fF",
		function()
			telescope.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
		end,
		desc = "find files incl hidden",
	},
	{ "<leader>fb", telescope.buffers, desc = "Buffers" },
	{
		"<leader>ff",
		function()
			telescope.find_files({ find_command = { "rg", "--files", "-g", "!.git" } })
		end,
		desc = "find files",
	},
	{ "<leader>fk", telescope.keymaps, desc = "Keymaps" },
	{ "<leader>fs", telescope.grep_string, desc = "Grep string under cursor" },
	{ "<leader>fv", telescope.git_status, desc = "Git status" },
	{ "<leader>fw", telescope.live_grep, desc = "Live grep" },
	{ "<leader>gC", telescope.git_commits, desc = "Commits" },
	{ "<leader>gb", telescope.git_branches, desc = "Branches" },
	{ "<leader>gd", "<cmd>Gvdiff<CR>", desc = "Diff" },
	{ "<leader>gr", "<cmd>Gread<CR", desc = "Reset changes" },
	{ "<leader>gw", "<cmd>Gwrite<CR", desc = "Stage changes" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
	{ "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostic" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev diagnostic" },
	{ "<leader>lp", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show signature" },
	{ "<leader>m", group = "misc" },
	{ "<leader>mf", ":ShowFilePath<CR>", desc = "File path" },
	{ "<leader>mh", ":nohl<CR>", desc = "Clear highlights" },
	{ "<leader>mi", ":InspectTree<CR>", desc = "Inspect AST via treesitter" },
	{ "<leader>mp", "<cmd>PeekOpen<CR>", desc = "Markdown peek open" },
	{ "<leader>mx", "<cmd>PeekClose<CR>", desc = "Close markdown peek" },
	{ "<leader>o", ":only<CR>", desc = "Keep current buffer only" },
	{ "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
	{ "<leader>s", group = "split" },
	{ "<leader>sh", "<C-w>s", desc = "Split horizontally" },
	{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	{ "<leader>sv", "<C-w>v", desc = "Split vertically" },
	{ "<leader>sx", "<cmd>close<CR>", desc = "Close current split" },
	{ "<leader>uw", ":set wrap!<cr>", desc = "Toggle word wrap" },
	{ "<leader>w", ":w<CR>", desc = "Write current buffer" },
	{ "<leader>x", group = "trouble" },
	{ "<leader>xL", "<cmd>Trouble loclist toggle focus=true<cr>", desc = "Loclist" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Buffer diagnostics" },
	{
		"<leader>xl",
		"<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
		desc = "LSP Definitions / references / ...",
	},
	{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics" },
	{
		"<leader>z",
		function()
			require("telescope").extensions.zoxide.list({})
		end,
		desc = "Zoxide",
	},
})

wk.add({
	{ "<leader>a", group = "Assistant", mode = "v" },
	{ "<leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste", mode = "v" },
	{ "<leader>as", ":<C-u>'<,'>GpStop<cr>", desc = "Stop generation", mode = "v" },
	{ "<leader>at", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle chat", mode = "v" },
})
