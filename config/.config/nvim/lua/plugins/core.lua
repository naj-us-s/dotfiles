return {

	{
		dir = vim.fn.stdpath("config") .. "/lua/oxocarbon",
		name = "oxocarbon",
		lazy = false,
		priority = 1000,
		config = function()
			require("oxocarbon")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		config = function()
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end

			configs.setup({
				ensure_installed = {
					"lua",
					"luadoc",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"scss",
					"python",
					"go",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"bash",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					-- full-stack additions
					"dockerfile",
					"graphql",
					"prisma",
					"sql",
				},

				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
						goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
					},
				},
			})
		end,
	},


	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
}
