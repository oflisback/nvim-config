local wk = require("which-key")
local telescope = require("telescope.builtin")

local keymap = vim.keymap

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

wk.register({
	a = {
		name = "assistant",
		n = { "<cmd>GpChatNew vsplit<cr>", "New Chat" },
		t = { "<cmd>GpChatToggle<cr>", "Toggle" },
		r = { "<cmd>GpChatRespond<cr>", "Respond" },
		f = { "<cmd>GpChatFinder<cr>", "Find chat" },
		s = { "<cmd>GpStop<cr>", "Stop generation" },
	},
	c = { ":bd<CR>", "Close current buffer" },
	o = { ":only<CR>", "Keep current buffer only" },
	f = {
		b = { telescope.buffers, "Buffers" },
		f = {
			function()
				telescope.find_files({ find_command = { "rg", "--files", "-g", "!.git" } })
			end,
			"find files",
		},
		w = { telescope.live_grep, "Live grep" },
		k = { telescope.keymaps, "Keymaps" },
		s = { telescope.grep_string, "Grep string under cursor" },
		v = { telescope.git_status, "Git status" },
		F = {
			function()
				telescope.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
			end,
			"find files incl hidden",
		},
	},
	l = {
		d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostic" },
		p = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show signature" },
		j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
		k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev diagnostic" },
	},
	m = {
		name = "misc",
		i = { ":InspectTree<CR>", "Inspect AST via treesitter" },
		h = { ":nohl<CR>", "Clear highlights" },
		p = { "<cmd>PeekOpen<CR>", "Markdown peek open" },
		x = { "<cmd>PeekClose<CR>", "Close markdown peek" },
	},
	r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
	s = {
		name = "split",
		v = { "<C-w>v", "Split vertically" },
		h = { "<C-w>s", "Split horizontally" },
		m = { "<cmd>MaximizerToggle<CR>", "Maximize/minimize a split" },
		x = { "<cmd>close<CR>", "Close current split" },
	},
	x = {
		name = "trouble",
		x = { "<cmd>Trouble diagnostics toggle focus=true<cr>", "Diagnostics" },
		X = { "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", "Buffer diagnostics" },
		l = { "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", "LSP Definitions / references / ..." },
		L = { "<cmd>Trouble loclist toggle focus=true<cr>", "Loclist" },
		q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix list" },
	},
	u = {
		w = { ":set wrap!<cr>", "Toggle word wrap" },
	},
	w = { ":w<CR>", "Write current buffer" },
	z = {
		function()
			require("telescope").extensions.zoxide.list({})
		end,
		"Zoxide",
	},
}, { mode = "n", prefix = "<leader>" })

wk.register({
	a = {
		name = "assistant",
		p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
		s = { "<cmd>GpStop<cr>", "Stop generation" },
		t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },
	},
}, { mode = "v", prefix = "<leader>" })
