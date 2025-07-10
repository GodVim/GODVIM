return {
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		build = ":TSUpdate",
		opts = {
			sync_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotag = {
				enable = true,
			},

			ensure_installed = {
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"gitignore",
				"java",
			},
		},
	},

	{
		"m-demare/hlargs.nvim",
		opts = {},
		event = "BufReadPre",
	},
}
