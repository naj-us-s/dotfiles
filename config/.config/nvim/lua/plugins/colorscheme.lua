return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local tokyonight = require("tokyonight")
    tokyonight.setup({
      style = "moon",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      -- Default line number color: Tokyo Night Moon green (applied by theme)
      on_highlights = function(hl, _c)
        hl.LineNr = { fg = "#9ece6a", bold = true }
        hl.CursorLineNr = { fg = "#ffffff", bold = true }
      end,
    })
    vim.cmd("colorscheme tokyonight")

    -- Line numbers: bright green, bold; current line number: white, bold (high visibility)
    local function apply_line_number_highlights()
      local opts = { fg = "#9ece6a", bold = true }
      local copts = { fg = "#ffffff", bold = true }
      if vim.g.transparent_enabled then
        opts.bg = "none"
        copts.bg = "none"
      end
      vim.api.nvim_set_hl(0, "LineNr", opts)
      vim.api.nvim_set_hl(0, "CursorLineNr", copts)
    end
    apply_line_number_highlights()
    -- Re-apply after any colorscheme change so line numbers stay visible
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = apply_line_number_highlights,
    })
    -- Re-apply after all plugins load (something may override LineNr)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(apply_line_number_highlights)
      end,
      once = true,
    })
    -- Re-apply when a buffer is shown so line numbers stay green (wins over other plugins)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      callback = apply_line_number_highlights,
    })

    -- Transparent background: groups to set bg = "none" when enabled
    local transparent_groups = {
      "Normal",
      "NormalFloat",
      "NormalNC",
      "SignColumn",
      "CursorLine",
      "CursorLineNr",
      "LineNr",
      "Folded",
      "NonText",
      "EndOfBuffer",
      "MsgArea",
      "Pmenu",
      "PmenuSel",
      "PmenuSbar",
      "PmenuThumb",
      "TelescopeNormal",
      "TelescopeBorder",
      "WhichKeyFloat",
      "NotifyBackground",
      -- Nvim-Tree (file explorer)
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "NvimTreeEndOfBuffer",
      "NvimTreeCursorLine",
      "NvimTreeSignColumn",
      "NvimTreeRootFolder",
    }

    local state_file = vim.fn.stdpath("state") .. "/transparent_enabled"

    local function apply_transparent()
      for _, name in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, name, { bg = "none" })
      end
      -- Keep line number colors (green/white) when transparent
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#9ece6a", bold = true, bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true, bg = "none" })
    end

    local function save_transparent_state(enabled)
      local ok, err = pcall(function()
        local f = io.open(state_file, "w")
        if f then
          f:write(enabled and "1" or "0")
          f:close()
        end
      end)
      if not ok and err then
        vim.notify("Could not save transparency state: " .. tostring(err), vim.log.levels.WARN)
      end
    end

    local function restore_transparent_state()
      local f = io.open(state_file, "r")
      if not f then
        return false
      end
      local content = f:read("*a")
      f:close()
      return content:match("^%s*1") ~= nil
    end

    vim.g.transparent_enabled = restore_transparent_state()
    if vim.g.transparent_enabled then
      apply_transparent()
    end

    local function toggle_transparent()
      vim.g.transparent_enabled = not vim.g.transparent_enabled
      if vim.g.transparent_enabled then
        apply_transparent()
        save_transparent_state(true)
      else
        vim.cmd("colorscheme tokyonight")
        apply_line_number_highlights()
        save_transparent_state(false)
      end
    end

    vim.keymap.set("n", "<leader>ut", toggle_transparent, { desc = "Toggle transparent background" })
  end,
}
