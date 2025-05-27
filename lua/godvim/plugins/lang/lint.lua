return  {
  "mfussenegger/nvim-lint",
  ft = { "js", "ts", "tsx", "jsx" },
  config = function()
    require('lint').linters_by_ft = {
      js = { "biomejs" },
      ts = { "biomejs" },
      tsx = { "biomejs" },
      jsx = { "biomejs" },
    }
  end,
}
