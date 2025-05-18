return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    version = false,
  },
  {
    "echasnovski/mini.files",
    cmd = "MiniFiles",
    version = false,
    config = function()
      require("mini.files").setup()
      require("mini.icons").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.notify",
    event = "BufReadPost",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = "InsertEnter",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.tabline",
    event = "BufReadPost", -- Load only after a real file is opened
    version = false,
    config = function()
      require("mini.tabline").setup()
    end,
  },
  {
    "echasnovski/mini.snippets",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    config = function()
      local gen_loader = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        snippets = {
          --	{ prefix = "usaco", body = "/*\nID: INSERT_USER\nPROB: INSERT_PROB\nLANG: INSERT_LANG\n*/", desc = "Snip" },
          gen_loader.from_file("~/.config/nvim/snippets/global.json"),

          gen_loader.from_lang(),
        },
      })
    end,
  },
}
