return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		vim.api.nvim_create_user_command("Browse", function(opts)
			vim.fn.system({ "open", opts.fargs[1] })
		end, { nargs = 1 })

		wk.add({
			{ "<leader>g", group = "Git" },
			{ "<leader>ga", "<cmd>Git commit --amend<CR>", desc = "Amend" },
			{ "<leader>gc", "<cmd>Git commit --verbose<CR>", desc = "Commit" },
		})
	end,
	dependencies = { "tpope/vim-rhubarb" },
	event = "VeryLazy",
}
