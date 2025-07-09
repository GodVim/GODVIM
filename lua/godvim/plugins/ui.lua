return {
	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},

	-- Dashboard
	{
		"folke/snacks.nvim",
		event = "UiEnter",
		opts = {
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "l",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},

	-- Statusline
	{
		"echasnovski/mini.statusline",
		event = "BufReadPost",
		version = false,
		opts = {},
	},

	-- Tabline
	{
		"echasnovski/mini.tabline",
		event = "BufReadPost",
		version = false,
		opts = {},
	},

	-- Notifications
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = { },
  },

	-- Utils
	{
		"echasnovski/mini-git",
		lazy = true,
		version = false,
	},
	{
		"echasnovski/mini.diff",
		lazy = true,
		version = false,
	},
}
