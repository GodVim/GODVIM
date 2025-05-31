return {
  'kevinhwang91/nvim-ufo',
  event = "BufReadPre",
  cmd = {"UfoEnable"},
  config = function()
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  end,
  dependencies = {'kevinhwang91/promise-async'},
}
