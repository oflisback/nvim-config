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

		local function eslint_config_exists()
			local cwd = vim.fn.getcwd()
			local eslintrc_path = cwd .. "/.eslintrc"
			local eslintrc_js_path = cwd .. "/.eslintrc.js"
			local eslintrc_json_path = cwd .. "/.eslintrc.json"
			return vim.fn.filereadable(eslintrc_path) == 1
				or vim.fn.filereadable(eslintrc_js_path) == 1
				or vim.fn.filereadable(eslintrc_json_path) == 1
		end

		local function select_linter_and_try_lint()
			-- Check if the current file is one of the specified types
			local filetype = vim.bo.filetype
			if
				filetype == "javascript"
				or filetype == "typescript"
				or filetype == "javascriptreact"
				or filetype == "typescriptreact"
			then
				-- Check if biome.json exists in the project root
				local cwd = vim.fn.getcwd()
				if vim.fn.filereadable(cwd .. "/biome.json") == 1 then
					-- Use biome if biome.json is present
					lint.try_lint("biomejs")
				elseif eslint_config_exists() then
					lint.try_lint("eslint")
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
