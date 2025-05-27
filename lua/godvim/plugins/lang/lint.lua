return  {
  "mfussenegger/nvim-lint",
  event = "User FilePost",
  config = function()
    require('lint').linters_by_ft = {
      js = { "biomejs" },
      ts = { "biomejs" },
      tsx = { "biomejs" },
      jsx = { "biomejs" },
    }
  end,
}
