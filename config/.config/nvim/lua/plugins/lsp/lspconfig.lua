return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    -- lazydev replaces neodev and works properly with blink.cmp
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.diagnostic.config({
      float = { border = "rounded" },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
      end,
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    vim.lsp.config("ts_ls", {})
    vim.lsp.config("html", {})
    vim.lsp.config("cssls", {})
    vim.lsp.config("tailwindcss", {})
    vim.lsp.config("svelte", {})
    vim.lsp.config("graphql", {})
    vim.lsp.config("emmet_ls", {})
    vim.lsp.config("eslint", {})
    vim.lsp.config("pyright", {})
    vim.lsp.config("prismals", {})
    vim.lsp.config("clangd", {})
    vim.lsp.config("omnisharp", {})
    vim.lsp.config("sqlls", {})
  end,
}
