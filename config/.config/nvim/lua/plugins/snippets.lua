return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"dsznajder/vscode-react-javascript-snippets",
	},
	config = function()
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.config.set_config({
			enable_autosnippets = true,
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { noremap = true, silent = true, desc = "Snippet: jump forward" })

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { noremap = true, silent = true, desc = "Snippet: jump backward" })

		vim.keymap.set("i", "<C-l>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { noremap = true, silent = true, desc = "Snippet: change choice" })
	end,
}
