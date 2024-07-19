local function biome_lsp_or_prettier()
	local has_prettier = vim.fs.find({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
	}, { upward = true })[1]

	if has_prettier then
		return { "prettier" }
	end

	local has_biome = vim.fs.find({
		"biome.json",
	}, { upward = true })[1]

	if has_biome then
		return { "biome" }
	end

	return {}
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = biome_lsp_or_prettier,
				typescript = biome_lsp_or_prettier,
				javascriptreact = biome_lsp_or_prettier,
				typescriptreact = biome_lsp_or_prettier,
				css = biome_lsp_or_prettier,
				html = biome_lsp_or_prettier,
				json = biome_lsp_or_prettier,
				yaml = biome_lsp_or_prettier,
				markdown = biome_lsp_or_prettier,
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
}
