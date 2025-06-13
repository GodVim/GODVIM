return {
  "Saghen/blink.cmp",
  dependencies = {
    -- This conditional loading is still a very good practice
    {
      "mikavilpas/blink-ripgrep.nvim",
      ft = {
        "lua", "javascript", "typescript", "rust", "go", "python", "markdown", "sh",
      },
    },
  },
  -- These events still act as the final trigger to *setup* the plugin
  event = {
    "InsertEnter",
    "CmdlineChanged",
  },
  version = "*",

  -- OPTIMIZATION: This `init` function is the key to our strategy.
  -- It runs when lazy.nvim processes the plugin spec (at startup), but *before*
  -- the plugin itself is loaded.
  init = function()
    -- We create an autocommand that will trigger once Neovim is fully loaded
    -- and idle (`VimEnter` event).
    -- This command will "pre-warm" the plugin by loading its Lua modules.
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("BlinkWarmup", { clear = true }),
      pattern = "*",
      -- The `once = true` is crucial. We only want this to run once per session.
      once = true,
      callback = function()
        -- Asynchronously load the plugin's main module.
        -- This gets the expensive part (file I/O, parsing) out of the way
        -- before you ever need it.
        vim.defer_fn(function()
          require("blink.cmp")
        end, 100) -- A small delay of 100ms to ensure it runs after everything else
      end,
    })
  end,

  -- We keep the config function for clean setup logic.
  config = function()
    -- The optimization of pre-loading mini.icons is still very valuable for runtime performance.
    local icons = require("mini.icons")
    local opts = {
      -- All your previous options remain the same. The change is in *when*
      -- the plugin is loaded, not how it's configured.
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
        default = { "snippets", "ripgrep", "lsp", "path", "buffer" },
        providers = {
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
    require("blink.cmp").setup(opts)
  end,
}
