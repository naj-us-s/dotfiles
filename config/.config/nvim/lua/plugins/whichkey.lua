return {
	"folke/which-key.nvim",
	event = "VeryLazy",

	opts = {
		preset = "modern",
		win = {
			border = "rounded",
			padding = { 1, 2 },
		},
		layout = { spacing = 6 },
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = "#525252" })

		wk.add({
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Git Hunks" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>s", group = "Splits" },
			{ "<leader>u", group = "Utility" },
			{ "<leader>t", group = "Tabs" },
			{ "<leader>c", group = "Code" },
			{ "<leader>r", group = "Substitute" },
			{ "<leader>a", group = "AI" },
			{ "<leader>as", group = "Supermaven" },
			{ "<leader>ac", group = "Copilot" },
			{ "<leader>o", group = "OpenCode" },
		})
	end,
}
