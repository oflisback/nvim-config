return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"jvgrootveld/telescope-zoxide",
			config = function()
				require("telescope").load_extension("zoxide")
			end,
		},
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local open_with_trouble = require("trouble.sources.telescope").open

		telescope.setup({
			defaults = {
				path_display = {
					"truncate",
				},
				layout_config = {
					horizontal = {
						preview_width = 0.6, -- Increase this to enlarge the preview window
						results_width = 0.4, -- Set how wide the results panel is
						width = 0.99,
					},
					vertical = {
						preview_cutoff = 40,
						preview_height = 0.6,
						width = 0.99,
					},
				},
				mappings = {
					i = {
						["<c-t>"] = open_with_trouble,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
					n = {
						["<c-t>"] = open_with_trouble,
					},
				},
			},
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
