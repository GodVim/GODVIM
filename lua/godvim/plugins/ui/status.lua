return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  dependencies = { "Zeioth/heirline-components.nvim" },
  opts = function()
    local lib = require("heirline-components.all")

    return {
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.file_info(),
        lib.component.breadcrumbs(),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.nav(),
      },
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
