return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- IMPORTANT: Configure mason-lspconfig with handlers for specific LSPs
		mason_lspconfig.setup({
			-- list of servers for mason to ensure are installed
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"gopls",
			},
			automatic_installation = true, -- install all listed servers if not already installed
			handlers = {
				-- This is the default handler that will be called for all servers
				-- that don't have a specific handler defined below (e.g., html, cssls, lua_ls, pyright, gopls).
				-- It will simply set up the LSP client with default capabilities for completion.
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						-- Add common settings for all LSPs here if needed
						-- Example: A shared on_attach function (already in your lspconfig.lua)
						-- on_attach = require("path.to.your_on_attach_function"),
					})
				end,

				-- Custom handler for 'ts_ls' (TypeScript Language Server / tsserver)
				ts_ls = function()
					local lspconfig = require("lspconfig")
					local util = require("lspconfig.util")
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						-- Activate ts_ls for Node.js/TypeScript projects
						root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"), -- .git is a common fallback
						single_file_support = false, -- Prevent it from attaching to single files
						settings = {
							-- Potentially useful settings for ts_ls in Node.js contexts
							typescript = {
								disableAutomaticTypeAcquisition = true,
							},
							javascript = {
								disableAutomaticTypeAcquisition = true,
							},
						},
					})
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"biome",
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint",
			},
		})
	end,
}
