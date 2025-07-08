return {
  "folke/snacks.nvim",
  event = "BufReadPre",
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    lazygit = { enabled = true },
    rename =  { enabled = true },
    dashboard = { enabled = true },
  }
}
