return {
  -- nvim-lint (linter)
  {
    "mfussenegger/nvim-lint",
    event = "BufEnter",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        json = { "biome" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        go = { "golangci_lint" },
        yaml = { "yamllint" },
        toml = { "taplo" },
      }

     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
