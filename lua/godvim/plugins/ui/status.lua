return {
  {
    "luukvbaal/statuscol.nvim",
    event="UiEnter",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
  relculright = true,
  segments = {
    {
      text = { builtin.foldfunc },
      click = "v:lua.ScFa" -- Example: vim.g.ScFa = function() vim.cmd("normal! za") end
    },
    {
      -- Segment for Diagnostic signs (e.g., from LSP)
      sign = { name = { "Diagnostic" } }, -- Only show signs named "Diagnostic"
      maxwidth = 2,                       -- Segment max width
      auto = true,                        -- Collapse segment if no diagnostic signs
      click = "v:lua.ScSa"                -- Example: vim.g.ScSa = function() vim.diagnostic.open_float() end
    },
    {
      text = { builtin.lnumfunc },
      click = "v:lua.ScLa"                -- Example: vim.g.ScLa = function() print("Line number clicked") end
    },
    {
      -- Segment for other signs (e.g., gitsigns, bookmarks)
      sign = { name = { ".*" } },         -- Match any other sign name (regex)
      maxwidth = 2,                       -- Segment max width
      colwidth = 1,                       -- Hint for sign column width within this segment
      auto = true,                        -- Collapse segment if no other signs
      click = "v:lua.ScSa"                -- Uses the same click handler as Diagnostic signs
    },
  }
}
    
      end,
  },
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    priority = "1",
    dependencies = { "Zeioth/heirline-components.nvim" },
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
