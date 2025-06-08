return {
  {
    "luukvbaal/statuscol.nvim",
    event="UiEnter",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },           
            click = "v:lua.ScSa"          
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa"  },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
            click = "v:lua.ScSa" 
          },
        }
      }
    end,
  },
  {
    "rebelot/heirline.nvim",
    event = "BufReadPre",
    priority = "1",
    dependencies = {
      "Zeioth/heirline-components.nvim",
      {
  "lmantw/themify.nvim",
  event ="VimEnter",
  opts = {
    {
      "folke/tokyonight.nvim",
      blacklist = { "tokyonight-day", "tokyonight-storm" },
    },
    {
      "everviolet/nvim",
      branch = "mega",
      blacklist = { "evergarden-winter", "evergarden-spring" },
    },
    {
      "catppuccin/nvim",
      blacklist = { "catppuccin-latte", "catppuccin-mocha" },
    },
    {
      "rose-pine/neovim",
      blacklist = { "rose-pine-dawn", "rose-pine-moon" },
    },
    {
      "rmehri01/onenord.nvim",
      branch = "main",
      blacklist = { "onenord-light" },
    },
    "navarasu/onedark.nvim",
    "gbprod/nord.nvim",
    "EdenEast/nightfox.nvim",
    "sainnhe/sonokai",
    "loctvl842/monokai-pro.nvim",
    "default"
  }
}

    },
    opts = function()
      local lib = require("heirline-components.all")

      return {
        statusline = {
          hl = { fg = "fg", bg = "bg" },
          lib.component.mode(),
          lib.component.file_info(),
          lib.component.git_diff(),
          lib.component.diagnostics(),
          lib.component.fill(),
          lib.component.cmd_info(),
          lib.component.fill(),
          lib.component.lsp(),
          lib.component.compiler_state(),
          lib.component.virtual_env(),
          lib.component.nav(),
        }
      }
    end,
    config = function(_, opts)
      vim.o.cmdheight = 0
      local heirline = require("heirline")
      local lib = require("heirline-components.all")

      -- Setup
      lib.init.subscribe_to_events()
      heirline.load_colors(lib.hl.get_colors())
      heirline.setup(opts)
    end,
  } 
}
