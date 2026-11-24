return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			auto_restore_enabled = false,
			suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			session_lens = {
				bufftypes_to_ignore = {},
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wl", "<cmd>AutoSession load<CR>")
		keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>")
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>")
	end,
}
