return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup({
			plugins = {
				presets = {
					operators = false, -- disables the builtin operator-pending mappings
					motions = false, -- disables the builtin motion mappings
					text_objects = false, -- disables the builtin text-object mappings
					windows = false, -- disables the builtin windows mappings
					nav = false, -- disables the builtin nav mappings
					z = false, -- disables the builtin z mappings
					g = false, -- disables the builtin g mappings
				},
			},
		})
	end,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {},
	dependencies = {
		"echasnovski/mini.nvim",
		version = false,
	},
}
