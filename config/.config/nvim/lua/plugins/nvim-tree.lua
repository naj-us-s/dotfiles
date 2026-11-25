return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "󰅂",
              arrow_open = "󰅀",
            },
          },
        },
        highlight_git = true,
        highlight_opened_files = "all",
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
  end,
  keys = {
    { "<leader>et", "<cmd>NvimTreeToggle<CR>",         desc = "Toggle Sidebar (NvimTree)" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>",       desc = "Collapse Explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>",        desc = "Refresh Explorer" },
    { "<leader>eF", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Locate File in Explorer" },
  },
}
