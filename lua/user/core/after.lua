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

local exitTerm = function()
	vim.cmd(":ToggleTerm")
end

vim.keymap.set("t", "<esc><esc>", exitTerm)

wk.add({
	{ "<leader>a", group = "assistant", mode = "n" },
	{ "<leader>af", "<cmd>GpChatFinder<cr>", desc = "Find chat" },
	{ "<leader>an", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat" },
	{ "<leader>ar", "<cmd>GpChatRespond<cr>", desc = "Respond" },
	{ "<leader>as", "<cmd>GpStop<cr>", desc = "Stop generation" },
	{ "<leader>at", "<cmd>GpChatToggle<cr>", desc = "Toggle" },
	{ "<leader>ae", ":DescribeCommandExecute<cr>", desc = "Execute described command" },
	{ "<leader>ao", ":DescribeCommandSuggest<cr>", desc = "Suggest described command" },

	{ "§", ":ToggleTerm<CR>", desc = "ToggleTerm" },

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
	{ "<leader>gg", "<cmd>:G<CR>", desc = "Vim fugitive status" },
	{ "<leader>gD", "<cmd>Gvdiff<CR>", desc = "Diff" },
	{ "<leader>gf", "<cmd>:G fetch<CR>", desc = "Git fetch" },
	{ "<leader>gp", "<cmd>:G push<CR>", desc = "Git push" },
	{ "<leader>gP", "<cmd>:G push --force<CR>", desc = "Git push --force" },
	{ "<leader>gss", "<cmd>:G stash<CR>", desc = "Git stash" },
	{ "<leader>gsp", "<cmd>:G stash pop<CR>", desc = "Git stash pop" },

	{ "<leader>grs", "<cmd>:CursorResetCommitSoft<CR>", desc = "Git reset soft to cursor ref" },
	{ "<leader>grm", "<cmd>:CursorResetCommitMixed<CR>", desc = "Git reset mixed to cursor ref" },
	{ "<leader>grh", "<cmd>:CursorResetCommitHard<CR>", desc = "Git reset hard to cursor ref" },
	{ "<leader>gy", "<cmd>:CursorCherryPickCommit<CR>", desc = "Git cherry-pick cursor ref" },
	{ "<leader>go", "<cmd>:CursorCheckOutCommit<CR>", desc = "Git checkout cursor ref" },
	{ "<leader>gd", "<cmd>:CursorDropCommit<CR>", desc = "Git drop cursor ref" },

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
