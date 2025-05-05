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
    opts = {}
  },
  {
    "echasnovski/mini.notify",
    event = "BufReadPost",
    version = false,
    opts = {}
  },
  {
    "echasnovski/mini.comment",
    event = "InsertEnter",
    version = false,
    opts = {}
  },
  {
    "echasnovski/mini.tabline",
    event = "BufReadPost", -- Load only after a real file is opened
    version = false,
    config = function()
      require("mini.tabline").setup()
      require("mini.icons").setup()
    end,
  },
}
