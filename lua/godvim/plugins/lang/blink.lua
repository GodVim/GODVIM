return {
    "Saghen/blink.cmp",
    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
    },
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {e
      keymap = {
        preset = "super-tab",
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },
      snippets = { preset = "mini_snippets" },
      appearance = { nerd_font_variant = "mono" },
      cmdline = {
        completion = {
          menu = {
            auto_show = true
          },
          ghost_text = {
            enabled = true
          }
        }
      },
      signature = { window = { border = 'single' }, enabled = true, },
      completion = {
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        ghost_text = { enabled = true, show_with_menu = true },
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      sources = {
        default = {
          "snippets",
          "ripgrep",
          "lsp",
          "path",
          "buffer",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            score_offset = -4,
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_mix_len = 3,
              context_size = 5,
              max_filesize = "1M",
            },
          },
        },
      },
    },
}
