return {
  "barrettruth/live-server.nvim",
  keys = {
    { "<leader>us", "<cmd>LiveServerStart<CR>", desc = "Start Live Server" },
    { "<leader>ux", "<cmd>LiveServerStop<CR>", desc = "Stop Live Server" },
    { "<leader>ut", "<cmd>LiveServerToggle<CR>", desc = "Toggle Live Server" },
  },
  config = function()
    require("live-server").setup({
      port = 8080,
      browser = true,
    })
  end,
}
