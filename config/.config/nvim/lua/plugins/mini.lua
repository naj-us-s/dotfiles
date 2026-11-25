return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()

      require("mini.surround").setup({
        custom_surroundings = nil,
        highlight_duration = 500,
        mappings = {
          add            = "sa",
          delete         = "sd",
          find           = "sf",
          find_left      = "sF",
          highlight      = "sh",
          replace        = "sr",
          update_n_lines = "sn",
        },
      })

      require("mini.ai").setup()
    end,
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<space>m", "<cmd>TSJToggle<cr>", desc = "Toggle split/join block" },
      { "<space>j", "<cmd>TSJJoin<cr>", desc = "Join block" },
      { "<space>s", "<cmd>TSJSplit<cr>", desc = "Split block" },
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        enable_check_bracket_line = false,
      })
    end,
  },

}
