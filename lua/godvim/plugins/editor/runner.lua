return {
  "aliqyan-21/runTA.nvim",
  config = function()
    require("runTA.commands").setup()
  end,
  cmd = { "RunCode", "ReopenLastOutput", "Output" },
}
