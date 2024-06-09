return {
	"andymass/vim-matchup",
	lazy = false,
	require = "nvim-treesitter/nvim-treesitter",
	after = "nvim-treesitter",
	config = function()
		vim.g.matchup_matchparen_offscreen = {}
		vim.g.matchup_matchparen_deferred = 1
		vim.api.nvim_del_keymap("", "z%")
	end,
}
