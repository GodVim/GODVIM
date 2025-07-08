return {
  "folke/snacks.nvim",
  event = "BufReadPre",
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = { enabled = true },
    profiler = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    rename =  { enabled = true },
  },
  keys = {
    { "<leader>pp", "<cmd>lua Snacks.toggle.profiler()<cr>", desc = "Profiler Scratch Bufer" },
    { "<leader>ph", "<cmd>lua Snacks.toggle.profiler_highlights()<cr>", desc = "Profiler Scratch Bufer" },   
    { "<leader>ps", "<cmd>lua Snacks.profiler.scratch()<cr>", desc = "Profiler Scratch Bufer" },
  }
}
