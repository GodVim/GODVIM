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
    rename =  { enabled = true },
  }
}
