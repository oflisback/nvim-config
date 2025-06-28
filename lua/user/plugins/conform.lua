local function conditional_ts_formatter()
	local has_prettier = vim.fs.find({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
	}, { path = vim.fn.expand("%:p:h"), upward = true })[1]

	if has_prettier then
		return { "prettier" }
	end

	local has_biome = vim.fs.find({
		"biome.json",
	}, { path = vim.fn.expand("%:p:h"), upward = true })[1]

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
				javascript = conditional_ts_formatter,
				typescript = conditional_ts_formatter,
				javascriptreact = conditional_ts_formatter,
				typescriptreact = conditional_ts_formatter,
				svelte = conditional_ts_formatter,
				css = conditional_ts_formatter,
				html = conditional_ts_formatter,
				json = conditional_ts_formatter,
				yaml = conditional_ts_formatter,
				markdown = conditional_ts_formatter,
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "golines" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
}
