local M = {}

-- Apply ESLint code actions on save (equivalent to VSCode's source.fixAll)
function M.apply_eslint_code_actions()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })

	if #clients == 0 then
		return
	end

	-- Get all code actions for the entire buffer
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(),
		range = {
			start = { line = 0, character = 0 },
			["end"] = {
				line = vim.api.nvim_buf_line_count(bufnr) - 1,
				character = 0,
			},
		},
		context = {
			diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
			only = { "source.fixAll.eslint" },
		},
	}

	-- Request code actions
	vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx, config)
		if err or not result or #result == 0 then
			return
		end

		-- Apply all code actions
		for _, action in ipairs(result) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			elseif action.command then
				vim.lsp.buf.execute_command(action.command)
			end
		end
	end)
end

-- Check if we should apply code actions for the current buffer
function M.should_apply_code_actions()
	local tool_detection = require("user.utils.tool-detection")
	local filetype = vim.bo.filetype

	-- Apply to JS/TS/Svelte files with ESLint config
	if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
		or filetype == "svelte"
	then
		return tool_detection.eslint_config_exists()
	end

	return false
end

return M

