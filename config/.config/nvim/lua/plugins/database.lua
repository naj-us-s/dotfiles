return {
	{
		"tpope/vim-dadbod",
		cmd = "DB",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		dependencies = {
			"tpope/vim-dadbod",
		},
		keys = {
			{ "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-ui",
		},
		ft = { "sql", "mysql", "plsql" },
		config = function() end,
	},
}
