return {
	"rebelot/heirline.nvim",
	event = "UiEnter",
	dependencies = { "Zeioth/heirline-components.nvim" },
	opts = function()
		local lib = require("heirline-components.all")
		return {
			statusline = { -- UI statusbar
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
		local heirline_components = require("heirline-components.all")

		-- Setup
		heirline_components.init.subscribe_to_events()
		heirline.load_colors(heirline_components.hl.get_colors())
		heirline.setup(opts)
	end,
}
