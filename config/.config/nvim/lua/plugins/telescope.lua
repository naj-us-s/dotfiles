return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",   desc = "Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",     desc = "Recent files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>",    desc = "Live grep" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>",  desc = "Grep word under cursor" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "Open buffers" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",      desc = "Keymaps" },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")
    local actions   = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display     = { "truncate" },
        prompt_prefix    = "  ",
        selection_caret  = "",
        entry_prefix     = "",
        sorting_strategy = "ascending",
        layout_config    = { prompt_position = "top" },
        preview = { treesitter = false },
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local hl = vim.api.nvim_set_hl
    hl(0, "TelescopeBorder",        { fg = "#525252" })
    hl(0, "TelescopePromptBorder",  { fg = "#525252" })
    hl(0, "TelescopeResultsBorder", { fg = "#525252" })
    hl(0, "TelescopePreviewBorder", { fg = "#525252" })
  end,
}
