return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    require("blink.cmp").setup({
      keymap = { preset = "default" },

      completion = {
        trigger = {
          show_on_insert_on_trigger_character = true,
        },
        list = {
          max_items = 200,
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
        ghost_text = { enabled = false },
      },

      sources = {
        default = { "lsp", "snippets", "buffer", "path" },
        per_filetype = {
          sql = { "lsp", "snippets", "buffer" },
        },
        providers = {
          lsp = {
            async = true,
            timeout_ms = 2000,
            min_keyword_length = 0,
          },
          buffer = {
            opts = { get_bufnrs = vim.api.nvim_list_bufs },
            min_keyword_length = 2,
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 1,
          },
        },
      },

      snippets = {
        preset = "luasnip",
      },

      fuzzy = {
        implementation = "lua",
      },

      appearance = {
        nerd_font_variant = "mono",
      },
    })
  end,
}
