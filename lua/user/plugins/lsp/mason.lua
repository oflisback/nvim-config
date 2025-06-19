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
				"tailwindcss", -- Add TailwindCSS LSP
				"lua_ls",
				"emmet_ls",
				"pyright",
				"gopls",
			},
			automatic_installation = true,
			handlers = {
				-- Default handler
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,

				-- Custom handler for 'ts_ls'
				ts_ls = function()
					local lspconfig = require("lspconfig")
					local util = require("lspconfig.util")
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
						single_file_support = false,
						settings = {
							typescript = {
								disableAutomaticTypeAcquisition = true,
							},
							javascript = {
								disableAutomaticTypeAcquisition = true,
							},
						},
					})
				end,

				tailwindcss = function()
					local lspconfig = require("lspconfig")
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"astro",
							"markdown",
							"mdx",
						},
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										-- Add custom regex patterns if you use class names in unusual places
										"tw`([^`]*)",
										'tw="([^"]*)',
										'tw={"([^"}]*)',
										"tw\\.\\w+`([^`]*)",
										"tw\\(.*?\\)`([^`]*)",
									},
								},
								validate = true,
								lint = {
									cssConflict = "warning",
									invalidApply = "error",
									invalidConfigPath = "error",
									invalidScreen = "error",
									invalidTailwindDirective = "error",
									invalidVariant = "error",
									recommendedVariantOrder = "warning",
								},
							},
						},
					})
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"biome",
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint",
			},
		})
	end,
}
