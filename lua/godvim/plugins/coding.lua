return {
  -- Autopairs
  { "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },

  -- Surround
  { "echasnovski/mini.surround", event = "InsertEnter", opts = {} },



  -- Blink.cmp
  {
    "Saghen/blink.cmp",
    event = "User FilePost",
    version = "*",
    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
    },
    opts = {
      keymap = { preset = "enter" },
      cmdline = {
        completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
      },
      completion = {
        list = { selection = { auto_insert = false } },
      },
      sources = {
        default = {  "lsp", "ripgrep" },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
          },
        },
      },
    },
  },
}
