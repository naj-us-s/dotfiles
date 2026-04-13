return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local kanagawa_blue = "#7FB4CA"
    for i = 0, 8 do
      for j = 0, 5 do
        local hl_name = "AlphaHeader" .. i .. "_" .. j
        vim.api.nvim_set_hl(0, hl_name, { fg = kanagawa_blue })
      end
    end

    local logo = [[
                                              
       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████

      ]]

    local utils = require("alpha.utils")
    local header_val = vim.split(logo, "\n")
    local header_hl = {}
    for i = 1, #header_val do
      header_hl[i] = { { "AlphaHeader0_0", 1, #header_val[i] } }
    end
    header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)

    dashboard.section.header.opts.hl = header_hl
    dashboard.section.header.val = header_val

    -- Buttons
    local init_path = vim.fn.stdpath("config")
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("r", "󰄉  Recent files", ":Telescope recent_files<CR>"),
      dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
      dashboard.button(
        "c",
        "󰈞  Find file in C:",
        ":cd C: | silent Telescope find_files hidden=true no_ignore=true <CR>"
      ),
      dashboard.button(
        "d",
        "󰮗  Find file in D:",
        ":cd D: | silent Telescope find_files hidden=true no_ignore=true <CR>"
      ),
      dashboard.button("s", "  Settings", ":cd " .. init_path .. "<CR>:e init.lua<CR>"),
      dashboard.button("q", "󰿅  Quit", "<cmd>q<CR>"),
    }
    dashboard.section.buttons.opts.hl = "AlphaHeader0_0"

    -- Footer (plugin stats)
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      desc = "Add Alpha dashboard footer",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        dashboard.section.footer.val = {
          " ",
          " ",
          " ",
          " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    local group = vim.api.nvim_create_augroup("CleanDashboard", {})

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AlphaReady",
      callback = function()
        vim.opt.showcmd = false
        vim.opt.ruler = false
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      group = group,
      pattern = "<buffer>",
      callback = function()
        vim.opt.showcmd = true
        vim.opt.ruler = true
      end,
    })

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
