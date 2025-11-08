local function conditional_ts_formatter()
	local tool_detection = require("user.utils.tool-detection")
	return tool_detection.get_js_formatters()
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
			formatters = {
				pg_format = {
					command = "/usr/bin/pg_format",
				},
			},
			format_on_save = function(bufnr)
				-- Apply ESLint code actions first (for import sorting, etc.)
				local code_actions = require("user.utils.code-actions-on-save")
				if code_actions.should_apply_code_actions() then
					code_actions.apply_eslint_code_actions()
					-- Wait a bit for code actions to complete
					vim.defer_fn(function()
						-- Then apply formatting
						require("conform").format({
							bufnr = bufnr,
							lsp_fallback = false,
							async = false,
							timeout_ms = 1000,
						})
					end, 50)
					return {}  -- Don't format immediately
				else
					-- No ESLint, just format normally
					return {
						lsp_fallback = false,
						async = false,
						timeout_ms = 1000,
					}
				end
			end,
		})
	end,
}
