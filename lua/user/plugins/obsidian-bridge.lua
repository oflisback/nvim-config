return {
	dir = "~/repos/projs/public/obsidian-bridge.nvim/",
	--   "oflisback/obsidian-bridge.nvim",
	enabled = os.getenv("USER") ~= "olaflisback",
	dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
	config = function()
		require("obsidian-bridge").setup({
			scroll_sync = true,
			obsidian_server_address = "http://localhost:27123",
			picker = "snacks",
		})
	end,
	event = {
		"BufReadPre *.md",
		"BufNewFile *.md",
	},
	lazy = true,
}
