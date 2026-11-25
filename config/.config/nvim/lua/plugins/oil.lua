return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,

  opts = {
    columns = { "icon" },

    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    default_file_explorer = true,

    view_options = {
      show_hidden = true,
    },

    float = {
      padding = 2,
      max_width = 80,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["o"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["r"] = {
        desc = "Rename file",
        callback = function()
          vim.api.nvim_feedkeys("cw", "m", false)
        end,
      },
    },
  },

  keys = {
    { "<leader>ee", "<cmd>Oil<CR>",         desc = "Open file explorer (Oil)" },
    { "<leader>ef", "<cmd>Oil --float<CR>", desc = "Open file explorer (floating)" },
    { "-",          "<cmd>Oil<CR>",         desc = "Open parent directory" },
  },
}
