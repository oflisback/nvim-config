local wk = require("which-key")
local telescope = require("telescope.builtin")
local utils = require("telescope.utils")

local keymap = vim.keymap

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- fugitive-difftool, migrate us later.
-- Jump to the first quickfix entry
vim.api.nvim_create_user_command("Gcfir", require("fugitive-difftool").git_cfir, {})
-- To the last
vim.api.nvim_create_user_command("Gcla", require("fugitive-difftool").git_cla, {})
-- To the next
vim.api.nvim_create_user_command("Gcn", require("fugitive-difftool").git_cn, {})
-- To the previous
vim.api.nvim_create_user_command("Gcp", require("fugitive-difftool").git_cp, {})
-- To the currently selected
vim.api.nvim_create_user_command("Gcc", require("fugitive-difftool").git_cc, {})

vim.api.nvim_command('command! ShowFilePath lua print(vim.fn.expand("%:p"))')

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit" },
	callback = function()
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local reg = vim.v.event.regname
		if reg == "*" then
			local contents = vim.fn.getreg("*")
			local yank_type = vim.v.event.regtype
			vim.fn.setreg("+", contents, yank_type)
		end
	end,
})

keymap.set("n", "gx", ":execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>", { desc = "Open url" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
end, { silent = true })

local exitTerm = function()
	vim.cmd(":ToggleTerm")
end

vim.lsp.enable("svelte")

vim.keymap.set("t", "<esc><esc>", exitTerm)

wk.add({
	{ "<leader>a", group = "assistant", mode = "n" },
	{ "<leader>af", "<cmd>PrtChatFinder<cr>", desc = "Find chat" },
	{ "<leader>an", "<cmd>PrtChatNew vsplit<cr>", desc = "New Chat" },
	{ "<leader>ar", "<cmd>PrtChatRespond<cr>", desc = "Respond" },
	{ "<leader>as", "<cmd>GpStop<cr>", desc = "Stop generation" },
	{ "<leader>at", "<cmd>PrtChatToggle<cr>", desc = "Toggle" },
	{ "<leader>ae", ":DescribeCommandExecute<cr>", desc = "Execute described command" },
	{ "<leader>ao", ":DescribeCommandSuggest<cr>", desc = "Suggest described command" },
	{
		"<leader>fd",
		function()
			local cwd = utils.buffer_dir()
			if string.match(vim.api.nvim_buf_get_name(0), "^oil://") then
				local oil_dir = require("oil").get_current_dir()
				if oil_dir then
					cwd = oil_dir
				end
			end
			telescope.live_grep({
				search_dirs = { cwd },
			})
		end,
		desc = "Find word in directory (and below)",
	},
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
	{
		"<leader>fg",
		function()
			require("custom.glob_picker").glob_file_picker()
		end,
		desc = "Find files by glob pattern",
	},
	{ "<leader>fk", telescope.keymaps, desc = "Keymaps" },
	{ "<leader>fs", telescope.grep_string, desc = "Grep string under cursor" },
	{ "<leader>fv", telescope.git_status, desc = "Git status" },
	{ "<leader>fw", telescope.live_grep, desc = "Live grep" },
	{ "<leader>gC", telescope.git_commits, desc = "Commits" },
	{
		"<leader>gb",
		function()
			telescope.git_branches({ pattern = "--sort=-committerdate" })
		end,
		desc = "Branches",
	},
	{ "<leader>gg", "<cmd>:tab G<CR>", desc = "Vim fugitive status" },
	{ "<leader>gD", "<cmd>Gvdiff<CR>", desc = "Diff" },
	{ "<leader>gf", "<cmd>:G fetch<CR>", desc = "Git fetch" },
	{ "<leader>gl", "<cmd>:G log<CR>", desc = "Git log" },
	{ "<leader>glp", "<cmd>:G log -p<CR>", desc = "Git log -p" },
	{ "<leader>gls", "<cmd>:G log -s<CR>", desc = "Git log -s" },
	{ "<leader>glf", telescope.git_bcommits, desc = "Git log for current file" },
	{ "<leader>gp", "<cmd>:G push<CR>", desc = "Git push" },
	{ "<leader>gP", "<cmd>:G push --force<CR>", desc = "Git push --force" },
	{ "<leader>gss", "<cmd>:G stash<CR>", desc = "Git stash" },
	{ "<leader>gsp", "<cmd>:G stash pop<CR>", desc = "Git stash pop" },
	{ "<leader>gl", "<cmd>:G log<CR>", desc = "Git log" },
	{ "<leader>glp", "<cmd>:G log -p<CR>", desc = "Git log -p" },
	{ "<leader>gls", "<cmd>:G log --stat<CR>", desc = "Git log -s" },
	{ "<leader>glr", "<cmd>:G reflog<CR>", desc = "Git reflog" },

	{ "<leader>ghrs", "<cmd>:CursorResetSoft<CR>", desc = "Git reset soft to cursor ref" },
	{ "<leader>ghrm", "<cmd>:CursorResetMixed<CR>", desc = "Git reset mixed to cursor ref" },
	{ "<leader>ghrh", "<cmd>:CursorResetHard<CR>", desc = "Git reset hard to cursor ref" },
	{ "<leader>ghp", "<cmd>:CursorCherryPick<CR>", desc = "Git cherry-pick cursor ref" },
	{ "<leader>ghc", "<cmd>:CursorCheckOut<CR>", desc = "Git checkout cursor ref" },
	{ "<leader>ghd", "<cmd>:CursorDrop<CR>", desc = "Git drop cursor commit" },

	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
	{ "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostic" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev diagnostic" },
	{ "<leader>lp", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show signature" },
	{ "<leader>m", group = "misc" },
	{ "<leader>mz", ":ZenMode<CR>", desc = "Zen mode" },
	{ "<leader>mf", ":ShowFilePath<CR>", desc = "File path" },
	{ "<leader>mo", ":e ~/.config/nvim/README.md<CR>", desc = "Open config repo readme" },
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
	{ "<leader>ap", ":<C-u>'<,'>PrtChatPaste<cr>", desc = "Visual Chat Paste", mode = "v" },
	{ "<leader>as", ":<C-u>'<,'>GpStop<cr>", desc = "Stop generation", mode = "v" },
	{ "<leader>at", ":<C-u>'<,'>PrtChatToggle<cr>", desc = "Visual Toggle chat", mode = "v" },
})
