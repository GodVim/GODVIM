return {
	-- Notifications
	{
		"echasnovski/mini.notify",
		event = "User FilePost",
		opts = {
			  lsp_progress = {
				enable = false
			}
		},
	},


  -- Statusline Tabline Lsp
	{
		"nvchad/ui",
    event="VimEnter",
		config = function()
			require("nvchad")
			dofile(vim.g.base46_cache .. "defaults")
			dofile(vim.g.base46_cache .. "statusline")
			dofile(vim.g.base46_cache .. "tbline")
						dofile(vim.g.base46_cache .. "syntax")
			dofile(vim.g.base46_cache .. "blink")

			dofile(vim.g.base46_cache .. "lsp")
			dofile(vim.g.base46_cache .. "treesitter")
			dofile(vim.g.base46_cache .. "colors")
		end,
	},

  -- Colorscheme
	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
  
  -- Icons
	{
	  "nvim-tree/nvim-web-devicons",
    event = "User FilePost",
	  opts = function()
	    dofile(vim.g.base46_cache .. "devicons")
	    return { override = require "nvchad.icons.devicons" }
	  end,
	},

  -- Ui Library
	{
	"nvchad/volt",
		lazy = true,
	}
}
