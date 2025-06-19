return {
	"nvim-svelte/nvim-svelte-snippets",
	dependencies = "L3MON4D3/LuaSnip",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.stdpath("data") .. "/lazy/nvim-svelte-snippets" },
		})
	end,
	opts = {
		enabled = true, -- Enable/disable snippets globally
		auto_detect = true, -- Only load in SvelteKit projects
		prefix = "kit", -- Prefix for TypeScript snippets (e.g., kit-load)
	},
}
