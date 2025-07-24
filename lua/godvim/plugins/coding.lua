return {
  -- Autopairs
  { "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },

  -- Commenting
  { "echasnovski/mini.comment", event = "User FilePost", opts = {} },

  -- Surround
  { "echasnovski/mini.surround", event = "InsertEnter", opts = {} },

  -- Mini Snippets
  {
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
  },

  -- Codeium
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = true,
      virtual_text = {
        enabled = false,
        key_bindings = {
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    },
  },

  -- Blink.cmp
  {
    "Saghen/blink.cmp",
    event = { "User FilePost", "CmdlineChanged" },
    version = "*",
    dependencies = {
      "codeium.nvim",
--      "saghen/blink.compat",
      "mikavilpas/blink-ripgrep.nvim",
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
        default = { "codeium", "snippets", "lsp", "ripgrep" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
          },
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
