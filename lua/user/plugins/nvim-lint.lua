return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			svelte = { "eslint" },
			python = { "pylint" },
			golang = { "golangcilint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function select_linter_and_try_lint()
			local tool_detection = require("user.utils.tool-detection")

			-- Check if the current file is one of the specified types
			local filetype = vim.bo.filetype
			if
				filetype == "javascript"
				or filetype == "typescript"
				or filetype == "javascriptreact"
				or filetype == "typescriptreact"
			then
				local linter = tool_detection.get_js_linter()
				if linter then
					lint.try_lint(linter)
				end
			elseif filetype == "python" then
				local linter = tool_detection.get_python_linter()
				if linter then
					lint.try_lint(linter)
				end
			end
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				select_linter_and_try_lint()
			end,
		})
	end,
}
