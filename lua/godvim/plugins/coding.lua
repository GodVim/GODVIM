return {
  -- Autopairs
  { "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },

  -- Commenting
  { "echasnovski/mini.comment", event = "User FilePost", opts = {} },

  -- Surround
  { "echasnovski/mini.surround", event = "InsertEnter", opts = {} },



  -- Blink.cmp
  {
    "Saghen/blink.cmp",
    event = "User FilePost",
    version = "*",
    dependencies = {
      { "mikavilpas/blink-ripgrep.nvim", lazy = true },
    },
    opts = {
      keymap = { preset = "super-tab" },
      snippets = { preset = "mini_snippets" },
      cmdline = {
        completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
      },
      completion = {
        list = { selection = { auto_insert = false } },
      },
      sources = {
        default = { "snippets", "lsp", "ripgrep" },
          ripgrep = {
            name = "Ripgrep",
            module = "blink-ripgrep",
            score_offset = -4,
            opts = {
              prefix_mix_len = 3,
              context_size = 5,
              max_filesize = "1M",
            },
          },
        },
      },
    },
  },
}
