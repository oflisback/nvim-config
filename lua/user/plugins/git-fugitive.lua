return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		wk.register({
			name = "Git",
			a = { "<cmd>Git commit --amend<CR>", "Amend" },
			c = { "<cmd>Git commit --verbose<CR>", "Commit" },
		}, { prefix = "<leader>g" })
	end,
	event = "VeryLazy",
}
