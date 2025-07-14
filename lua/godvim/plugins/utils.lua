return {
	{
		"echasnovski/mini.files",
		cmd = "MiniFiles",
		version = false,
		config = function()
			require("mini.files").setup()
			require("mini.icons").setup()
		end,
	},

	{
		"folke/snacks.nvim",
		event = "BufReadPre",
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
		},
	},

	{
		"folke/snacks.nvim",
		event = "User FilePost",
		---@type snacks.Config
		opts = {
			rename = { enabled = true },
		},
	},


	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"echasnovski/mini.icons",
		lazy = true,
		version = false,
	},
}
