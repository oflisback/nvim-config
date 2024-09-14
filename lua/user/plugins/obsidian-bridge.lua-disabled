return {
	"oflisback/obsidian-bridge.nvim",
	enabled = os.getenv("USER") ~= "olaflisback",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("obsidian-bridge").setup({ scroll_sync = true })
	end,
	event = {
		"BufReadPre *.md",
		"BufNewFile *.md",
	},
	lazy = true,
}
