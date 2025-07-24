return {
  "echasnovski/mini.snippets",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local loader = require("mini.snippets").gen_loader
    require("mini.snippets").setup({
      snippets = {
        loader.from_file("~/.config/nvim/snippets/global.json"),
        loader.from_lang(),
      },
    })
  end,
}
