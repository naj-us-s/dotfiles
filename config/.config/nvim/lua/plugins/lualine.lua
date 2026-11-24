return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ox = require("oxocarbon").oxocarbon
		local mode_map = {
			["n"] = "RW",
			["i"] = "VIEX",
			["v"] = "**",
			["V"] = "**",
			["\22"] = "**",
			["c"] = "C",
		}

		local function custom_mode()
			local mode_code = vim.api.nvim_get_mode().mode
			return mode_map[mode_code] or mode_code
		end

		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { fg = ox.base00, bg = ox.base11, gui = "bold" },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base04, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
					insert = {
						a = { fg = ox.base00, bg = ox.base13, gui = "bold" },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base04, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
					visual = {
						a = { fg = ox.base00, bg = ox.base10, gui = "bold" },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base04, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
					replace = {
						a = { fg = ox.base00, bg = ox.base12, gui = "bold" },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base04, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
					command = {
						a = { fg = ox.base00, bg = ox.base14, gui = "bold" },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base04, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
					inactive = {
						a = { fg = ox.base00, bg = ox.base03 },
						z = { fg = ox.base04, bg = ox.base00, gui = "bold" },
						b = { fg = ox.base03, bg = ox.base00 },
						c = { fg = ox.base03, bg = ox.base00 },
					},
				},
				globalstatus = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { custom_mode },
				lualine_b = { "filename" },
				lualine_c = { "branch" },
				lualine_x = {
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = ox.base11 },
					},
					"diagnostics",
				},
				lualine_y = { "" },
				lualine_z = { "location" },
			},
		})
	end,
}
