return {
  "Saghen/blink.cmp",
  dependencies = {
    {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  build = ":Copilot auth",
  cmd = "Copilot",
  opts = {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false
    },
    filetypes = {
      markdown = true,
      help = true
    }
  }
},

    "mikavilpas/blink-ripgrep.nvim",
    "giuxtaposition/blink-cmp-copilot",
  },
  event = {
    "InsertEnter",
    "CmdlineChanged",
  },
  version = "*",

  opts = function()
    local icons = require("mini.icons")
    return {
      keymap = { preset = "super-tab" },
      snippets = { preset = "mini_snippets" },
      appearance = { nerd_font_variant = "mono" },
      cmdline = {
        completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
      },
      signature = { window = { border = "single" }, enabled = true },
      completion = {
        -- Keeping documentation off by default is still a good performance choice.
        documentation = { auto_show = false },
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        ghost_text = { enabled = true, show_with_menu = true },
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = icons.get("lsp", ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = icons.get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = icons.get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      sources = {
        default = { "copilot", "snippets", "lsp", "ripgrep" },
        providers = {
           copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            score_offset = -4,
            opts = {
              prefix_mix_len = 3,
              context_size = 5,
              max_filesize = "1M",
            },
          },
        },
      },
    }
  end,
}
