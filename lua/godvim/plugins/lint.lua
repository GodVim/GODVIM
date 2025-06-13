return {
  {
    "nvimdev/guard.nvim",
    config = function()
      local ft = require('guard.filetype')
      ft('typescript,javascript'):fmt('biome'):fmt('prettierd'):lint('eslint')
      ft('java'):fmt("google-java-format")
      ft('python'):fmt('isort')
        :append('black')
        :lint('mypy')
        :append('mypyc')
        :append('dmypy')
    end,
  },
  "nvimdev/guard-collection"
}
