return {
	"oflisback/cursor-git-ref-command.nvim",
	config = function()
		require("cursor-git-ref-command").setup()
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
}
