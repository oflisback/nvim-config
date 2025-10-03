return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>dt", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
		{ "<leader>dr", ":normal vip<CR><PLUG>(DBUI_ExecuteQuery)", desc = "Execute query" },
	},
	config = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_execute_on_save = 0
		vim.g.dbs = {
			{ name = "poe2_db", url = os.getenv("POE2_DB") },
		}
	end,
}
