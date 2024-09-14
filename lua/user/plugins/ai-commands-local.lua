return {
	dir = "~/repos/projs/public/ai-commands.nvim",
	config = function()
		require("ai-commands").setup({
			openai_api_key_command = "~/.config/echo-openai-key-apa.sh",
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	enabled = true,
	lazy = false,
}
