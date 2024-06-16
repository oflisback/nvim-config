return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		vim.api.nvim_create_user_command("Browse", function(opts)
			vim.fn.system({ "open", opts.fargs[1] })
		end, { nargs = 1 })

		wk.register({
			name = "Git",
			a = { "<cmd>Git commit --amend<CR>", "Amend" },
			c = { "<cmd>Git commit --verbose<CR>", "Commit" },
		}, { prefix = "<leader>g" })
	end,
	dependencies = { "tpope/vim-rhubarb" },
	event = "VeryLazy",
}
